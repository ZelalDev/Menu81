// Models/Menu.swift
// Menü 81
//
// Veri modeli — JSON'dan Codable ile decode edilir.
// Her Menu bir güne, her Meal bir öğüne karşılık gelir.

import Foundation

// MARK: - Root Response

struct MenuResponse: Codable {
    let menus: [Menu]
}

// MARK: - Menu (Bir Günün Tüm Verisi)

struct Menu: Codable, Identifiable {
    let id: UUID
    let date: Date
    let breakfast: Meal
    let dinner: Meal
    let totalCalories: Int

    // JSON'daki alan adlarını Swift property adlarıyla eşleştir
    enum CodingKeys: String, CodingKey {
        case date
        case breakfast
        case dinner
        case totalCalories
    }

    // UUID'yi biz üretiyoruz, JSON'dan gelmesi gerekmiyor
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Tarihi "yyyy-MM-dd" formatında parse et
        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "tr_TR")

        guard let parsedDate = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .date,
                in: container,
                debugDescription: "Tarih formatı hatalı: \(dateString). Beklenen format: yyyy-MM-dd"
            )
        }

        self.id = UUID()
        self.date = parsedDate
        self.breakfast = try container.decode(Meal.self, forKey: .breakfast)
        self.dinner = try container.decode(Meal.self, forKey: .dinner)
        self.totalCalories = try container.decode(Int.self, forKey: .totalCalories)
    }
}

// MARK: - Meal (Tek Öğün)

struct Meal: Codable {
    let items: [String]
    let calories: Int
}

// MARK: - MealType (Öğün Türü)

/// Kahvaltı ve akşam yemeği için görsel kimlik tanımlar.
/// View katmanı bu enum üzerinden ikon, renk ve başlık alır.
enum MealType {
    case breakfast
    case dinner

    var title: String {
        switch self {
        case .breakfast: return "Kahvaltı"
        case .dinner:    return "Akşam Yemeği"
        }
    }

    var systemIcon: String {
        switch self {
        case .breakfast: return "sun.horizon.fill"
        case .dinner:    return "moon.stars.fill"
        }
    }

    var timeLabel: String {
        switch self {
        case .breakfast: return "07:00 – 09:00"
        case .dinner:    return "17:30 – 19:30"
        }
    }
}
