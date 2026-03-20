// Views/Styles/AppTheme.swift
// Menü 81
//
// Tüm renk, tipografi ve tasarım sabitleri tek yerden yönetilir.
// Yeni bir tema veya dark-mode tweaki için sadece bu dosyayı düzenle.

import SwiftUI

// MARK: - Color Palette



// MARK: - Meal Type Theme

/// Her öğün tipi için renk ve ikon çifti.
extension MealType {
    var primaryColor: Color {
        switch self {
        case .breakfast: return .breakfastPrimary
        case .dinner:    return .dinnerPrimary
        }
    }

    var lightColor: Color {
        switch self {
        case .breakfast: return .breakfastLight
        case .dinner:    return .dinnerLight
        }
    }
}

// MARK: - Spacing & Radius

enum AppSpacing {
    static let xs:  CGFloat = 4
    static let sm:  CGFloat = 8
    static let md:  CGFloat = 16
    static let lg:  CGFloat = 24
    static let xl:  CGFloat = 32
    static let xxl: CGFloat = 48
}

enum AppRadius {
    static let sm:  CGFloat = 10
    static let md:  CGFloat = 16
    static let lg:  CGFloat = 24
}

// MARK: - Typography Modifiers

struct HeadlineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22, weight: .bold, design: .rounded))
            .foregroundStyle(Color.textPrimary)
    }
}

struct SubheadlineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13, weight: .medium, design: .rounded))
            .foregroundStyle(Color.textSecondary)
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .foregroundStyle(Color.textPrimary)
    }
}

extension View {
    func headlineStyle()    -> some View { modifier(HeadlineStyle()) }
    func subheadlineStyle() -> some View { modifier(SubheadlineStyle()) }
    func bodyStyle()        -> some View { modifier(BodyStyle()) }
}
