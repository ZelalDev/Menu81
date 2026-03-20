// Utilities/DateExtensions.swift
// Menü 81

import Foundation

extension Date {

    /// "Pazartesi" → gün adı (kısa)
    var shortWeekday: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "tr_TR")
        f.dateFormat = "EEE"          // "Pzt", "Sal" …
        return f.string(from: self).capitalized
    }

    /// "09" → gün numarası
    var dayNumber: String {
        let f = DateFormatter()
        f.dateFormat = "dd"
        return f.string(from: self)
    }

    /// "Haziran 2025"
    var monthYearString: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "tr_TR")
        f.dateFormat = "MMMM yyyy"
        return f.string(from: self).capitalized
    }

    /// "9 Haziran, Pazartesi"
    var fullTurkishDate: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "tr_TR")
        f.dateFormat = "d MMMM, EEEE"
        return f.string(from: self).capitalized
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    /// "Bugün", "Yarın" veya kısa gün adı
    var relativeDayLabel: String {
        if isToday    { return "Bugün" }
        if isTomorrow { return "Yarın" }
        return shortWeekday
    }
}
