// Views/HomeView.swift
// Menü 81
//
// Ana ekran.
// Üst: Tarih şeridi (DayTabView)
// Alt: Seçili günün menüsü (MenuDayView)
// Hata ve yükleme durumları ayrıca ele alınmış.

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel = MenuViewModel()

    var body: some View {
        ZStack {
            // Arka plan rengi
            Color.appBackground
                .ignoresSafeArea()

            switch viewModel.loadState {
            case .idle, .loading:
                loadingView

            case .failure(let message):
                errorView(message: message)

            case .success:
                mainContent
            }
        }
    }

    // MARK: - Ana İçerik

    private var mainContent: some View {
        VStack(spacing: 0) {

            // ── Navigation Bar Alanı ──────────────────────────
            navBar

            // ── Tarih Şeridi ──────────────────────────────────
            DayTabView(
                menus: viewModel.menus,
                selectedMenu: Binding(
                    get: { viewModel.selectedMenu },
                    set: { if let m = $0 { viewModel.select(m) } }
                )
            )

            Divider()

            // ── Menü İçeriği ──────────────────────────────────
            if let menu = viewModel.selectedMenu {
                MenuDayView(menu: menu)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .id(menu.id)      // ID değişince view yeniden oluşur → animasyon tetiklenir
                    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: menu.id)
            }
        }
    }

    // MARK: - Navigation Bar

    private var navBar: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Menü 81")
                    .font(.system(size: 26, weight: .heavy, design: .rounded))
                    .foregroundStyle(Color.textPrimary)

                if let month = viewModel.selectedMenu?.date.monthYearString {
                    Text(month)
                        .subheadlineStyle()
                }
            }

            Spacer()

            // İleride profil / bildirim ikonu eklenebilir
            Button {
                Task { await viewModel.loadMenus() }
            } label: {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.textSecondary)
                    .frame(width: 36, height: 36)
                    .background(
                        Circle()
                            .fill(Color.cardBackground)
                            .shadow(color: .black.opacity(0.07), radius: 6, x: 0, y: 2)
                    )
            }
        }
        .padding(.horizontal, AppSpacing.md)
        .padding(.top, AppSpacing.sm)
        .padding(.bottom, AppSpacing.xs)
    }

    // MARK: - Loading

    private var loadingView: some View {
        VStack(spacing: AppSpacing.md) {
            ProgressView()
                .scaleEffect(1.3)
                .tint(Color.textSecondary)

            Text("Menü yükleniyor...")
                .subheadlineStyle()
        }
    }

    // MARK: - Error

    private func errorView(message: String) -> some View {
        VStack(spacing: AppSpacing.lg) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 44))
                .foregroundStyle(Color.breakfastPrimary)

            Text("Bir sorun oluştu")
                .headlineStyle()

            Text(message)
                .subheadlineStyle()
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppSpacing.xl)

            Button("Tekrar Dene") {
                Task { await viewModel.loadMenus() }
            }
            .font(.system(size: 15, weight: .semibold, design: .rounded))
            .foregroundStyle(.white)
            .padding(.horizontal, AppSpacing.xl)
            .padding(.vertical, AppSpacing.sm)
            .background(
                Capsule().fill(Color.textPrimary)
            )
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView()
}
