// Views/Components/MealCardView.swift
// Menü 81
//
// Tek bir öğünü (kahvaltı veya akşam yemeği) gösteren kart.
// MealType üzerinden renk, ikon ve başlık otomatik belirlenir.

import SwiftUI

struct MealCardView: View {

    let meal: Meal
    let type: MealType

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── Kart Başlığı ──────────────────────────────────
            cardHeader

            Divider()
                .padding(.horizontal, AppSpacing.md)

            // ── Yemek Listesi ─────────────────────────────────
            itemList
                .padding(.top, AppSpacing.sm)
                .padding(.bottom, AppSpacing.md)
        }
        .background(
            RoundedRectangle(cornerRadius: AppRadius.lg)
                .fill(Color.cardBackground)
                .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
        )
    }

    // MARK: - Header

    private var cardHeader: some View {
        HStack(alignment: .center) {

            // İkon
            ZStack {
                Circle()
                    .fill(type.lightColor)
                    .frame(width: 44, height: 44)

                Image(systemName: type.systemIcon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(type.primaryColor)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(type.title)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.textPrimary)

                Text(type.timeLabel)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundStyle(Color.textTertiary)
            }

            Spacer()

            // Kalori badge
            CalorieBadge(calories: meal.calories)
        }
        .padding(AppSpacing.md)
    }

    // MARK: - Item List

    private var itemList: some View {
        VStack(alignment: .leading, spacing: AppSpacing.xs) {
            ForEach(meal.items, id: \.self) { item in
                HStack(spacing: AppSpacing.sm) {
                    Circle()
                        .fill(type.primaryColor.opacity(0.5))
                        .frame(width: 5, height: 5)

                    Text(item)
                        .bodyStyle()
                        .lineLimit(1)
                }
            }
        }
        .padding(.horizontal, AppSpacing.md)
    }
}

// MARK: - Calorie Badge

struct CalorieBadge: View {
    let calories: Int

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "flame.fill")
                .font(.system(size: 11))
                .foregroundStyle(Color.calorieBadgeText)

            Text("\(calories) kcal")
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(Color.calorieBadgeText)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(Color.calorieBadge)
        )
    }
}

// MARK: - Preview

#Preview {
    let meal = Meal(
        items: ["Beyaz Peynir", "Zeytin", "Haşlanmış Yumurta", "Simit", "Çay"],
        calories: 480
    )

    VStack(spacing: 16) {
        MealCardView(meal: meal, type: .breakfast)
        MealCardView(
            meal: Meal(items: ["Mercimek Çorbası", "Tavuk Sote", "Bulgur Pilavı", "Ekmek"], calories: 720),
            type: .dinner
        )
    }
    .padding()
    .background(Color.appBackground)
}
