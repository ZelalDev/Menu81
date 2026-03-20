// Views/Components/MenuDayView.swift
// Menü 81
//
// Seçili güne ait tam görünüm:
// Tarih başlığı + toplam kalori + kahvaltı ve akşam kartları.

import SwiftUI

struct MenuDayView: View {

    let menu: Menu

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {

                // ── Tarih & Özet Başlığı ──────────────────────
                headerSection

                // ── Kahvaltı Kartı ────────────────────────────
                MealCardView(meal: menu.breakfast, type: .breakfast)

                // ── Akşam Yemeği Kartı ────────────────────────
                MealCardView(meal: menu.dinner, type: .dinner)

                Spacer(minLength: AppSpacing.xxl)
            }
            .padding(.horizontal, AppSpacing.md)
            .padding(.top, AppSpacing.sm)
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                // "Bugün" / "Yarın" veya boşluk
                if menu.date.isToday {
                    Text("Bugünün Menüsü")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.breakfastPrimary)
                } else if menu.date.isTomorrow {
                    Text("Yarının Menüsü")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color.dinnerPrimary)
                }

                Text(menu.date.fullTurkishDate)
                    .headlineStyle()
            }

            Spacer()

            // Günlük toplam kalori
            VStack(alignment: .trailing, spacing: 2) {
                Text("Günlük Toplam")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(Color.textTertiary)

                CalorieBadge(calories: menu.totalCalories)
            }
        }
        .padding(.horizontal, AppSpacing.xs)
    }
}

// MARK: - Preview

#Preview {
    let json = """
    {"menus":[{
        "date":"2025-06-09",
        "breakfast":{"items":["Beyaz Peynir","Zeytin","Haşlanmış Yumurta","Simit","Çay"],"calories":480},
        "dinner":{"items":["Mercimek Çorbası","Tavuk Sote","Bulgur Pilavı","Cacık","Ekmek"],"calories":720},
        "totalCalories":1200
    }]}
    """
    let menu = try! JSONDecoder().decode(MenuResponse.self, from: json.data(using: .utf8)!).menus[0]

    MenuDayView(menu: menu)
        .background(Color.appBackground)
}
