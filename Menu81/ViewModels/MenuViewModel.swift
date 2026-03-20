// ViewModels/MenuViewModel.swift
// Menü 81
//
// Veri yükleme ve durum yönetimi.
// Şu an yerel JSON okur; ileride uzak API'ye geçiş için
// sadece `loadMenus()` metodunu güncellemeniz yeterli olacak.

import Foundation
import Combine

// MARK: - Load State

enum LoadState {
    case idle
    case loading
    case success
    case failure(String)
}

// MARK: - MenuViewModel

@MainActor
final class MenuViewModel: ObservableObject {

    // MARK: Published Properties

    @Published private(set) var menus: [Menu] = []
    @Published private(set) var selectedMenu: Menu?
    @Published private(set) var loadState: LoadState = .idle

    // MARK: Computed — Bugünün veya en yakın günün indeksi

    var todayIndex: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        // 1. Tam eşleşme: bugün
        if let idx = menus.firstIndex(where: {
            calendar.startOfDay(for: $0.date) == today
        }) { return idx }

        // 2. Gelecekteki en yakın gün
        if let idx = menus.firstIndex(where: {
            calendar.startOfDay(for: $0.date) > today
        }) { return idx }

        // 3. Hiçbiri yoksa son eleman
        return max(menus.count - 1, 0)
    }

    // MARK: Init

    init() {
        Task { await loadMenus() }
    }

    // MARK: - Veri Yükleme

    /// Yerel `menu_data.json` dosyasını okur ve `menus` dizisini doldurur.
    /// Uzak API entegrasyonu için bu metodun içini değiştir;
    /// dışarıya açık arayüz (Published properties) aynı kalır.
    func loadMenus() async {
        loadState = .loading

        // Kısa gecikme — gerçek API çağrısında bu satırı kaldır
        try? await Task.sleep(nanoseconds: 300_000_000)

        guard let url = Bundle.main.url(forResource: "menu_data", withExtension: "json") else {
            loadState = .failure("menu_data.json dosyası bulunamadı.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(MenuResponse.self, from: data)

            // Tarihe göre sırala (erken → geç)
            menus = response.menus.sorted { $0.date < $1.date }
            loadState = .success

            // Başlangıçta bugünün menüsünü seç
            if !menus.isEmpty {
                selectedMenu = menus[todayIndex]
            }

        } catch {
            loadState = .failure("Veri yüklenemedi: \(error.localizedDescription)")
        }
    }

    // MARK: - Seçim

    func select(_ menu: Menu) {
        selectedMenu = menu
    }

    // MARK: - Yardımcılar

    /// Verilen menünün tarih şeridindeki indeksini döner
    func index(of menu: Menu) -> Int {
        menus.firstIndex(where: { $0.id == menu.id }) ?? 0
    }

    /// Bugün mü?
    func isToday(_ menu: Menu) -> Bool {
        Calendar.current.isDateInToday(menu.date)
    }
}
