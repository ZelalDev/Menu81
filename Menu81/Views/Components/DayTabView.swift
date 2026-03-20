// Views/Components/DayTabView.swift
// Menü 81
//
// Üstteki yatay kaydırılabilir tarih şeridi.
// Seçili günü vurgular, "Bugün" etiketi gösterir.

import SwiftUI

struct DayTabView: View {

    let menus: [Menu]
    @Binding var selectedMenu: Menu?

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.sm) {
                    ForEach(menus) { menu in
                        DayCell(
                            menu: menu,
                            isSelected: selectedMenu?.id == menu.id
                        )
                        .id(menu.id)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedMenu = menu
                            }
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.sm)
            }
            // Seçili güne otomatik kaydır
            .onChange(of: selectedMenu?.id) { _, newID in
                guard let newID else { return }
                withAnimation(.easeInOut(duration: 0.35)) {
                    proxy.scrollTo(newID, anchor: .center)
                }
            }
            .onAppear {
                if let id = selectedMenu?.id {
                    proxy.scrollTo(id, anchor: .center)
                }
            }
        }
    }
}

// MARK: - Day Cell

private struct DayCell: View {

    let menu: Menu
    let isSelected: Bool

    var body: some View {
        VStack(spacing: AppSpacing.xs) {

            // "Bugün" / "Yarın" / "Pzt" etiketi
            Text(menu.date.relativeDayLabel)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(isSelected ? Color.white.opacity(0.9) : Color.textTertiary)

            // Gün numarası
            Text(menu.date.dayNumber)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(isSelected ? Color.white : Color.textPrimary)

            // Seçili nokta göstergesi
            Circle()
                .fill(isSelected ? Color.white.opacity(0.8) : Color.clear)
                .frame(width: 4, height: 4)
        }
        .frame(width: 52, height: 72)
        .background(
            RoundedRectangle(cornerRadius: AppRadius.md)
                .fill(isSelected ? Color.dateActive : Color.clear)
        )
        .contentShape(Rectangle())
    }
}

// MARK: - Preview

#Preview {
    let sampleMenus: [Menu] = {
        let json = """
        {"menus":[
            {"date":"2025-06-09","breakfast":{"items":["Çay"],"calories":80},"dinner":{"items":["Çorba"],"calories":300},"totalCalories":380},
            {"date":"2025-06-10","breakfast":{"items":["Çay"],"calories":80},"dinner":{"items":["Çorba"],"calories":300},"totalCalories":380},
            {"date":"2025-06-11","breakfast":{"items":["Çay"],"calories":80},"dinner":{"items":["Çorba"],"calories":300},"totalCalories":380}
        ]}
        """
        let data = json.data(using: .utf8)!
        return (try? JSONDecoder().decode(MenuResponse.self, from: data))?.menus ?? []
    }()

    @State var selected: Menu? = sampleMenus.first
    return DayTabView(menus: sampleMenus, selectedMenu: $selected)
        .background(Color.appBackground)
}
