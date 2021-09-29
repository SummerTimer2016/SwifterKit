//
//  Date+Extensions.swift
//  BFKit-Swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 - 2019 Fabrizio Brancati.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#if canImport(Foundation)
import Foundation

#if os(macOS) || os(iOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif


// MARK: - Date extension
// MARK: - Enums
 extension Date {
    /// SwifterSwift: Day name format.
    ///
    /// - threeLetters: 3 letter day abbreviation of day name.
    /// - oneLetter: 1 letter day abbreviation of day name.
    /// - full: Full day name.
    enum DayNameStyle {
        /// SwifterSwift: 3 letter day abbreviation of day name.
        case threeLetters
        
        /// SwifterSwift: 1 letter day abbreviation of day name.
        case oneLetter
        
        /// SwifterSwift: Full day name.
        case full
    }
    
    /// SwifterSwift: Month name format.
    ///
    /// - threeLetters: 3 letter month abbreviation of month name.
    /// - oneLetter: 1 letter month abbreviation of month name.
    /// - full: Full month name.
    enum MonthNameStyle {
        /// SwifterSwift: 3 letter month abbreviation of month name.
        case threeLetters
        
        /// SwifterSwift: 1 letter month abbreviation of month name.
        case oneLetter
        
        /// SwifterSwift: Full month name.
        case full
    }
    /// Editable date components.
    ///
    /// - year: Year component.
    /// - month: Month component.
    /// - day: Day component.
    /// - hour: Hour component.
    /// - minute: Minute component.
    /// - second: Second component.
    enum EditableDateComponents: Int {
        case year
        case month
        case day
        case hour
        case minute
        case second
    }
}
// MARK: - Properties
/// This extension add some useful functions to Date.
 extension Date {
    
    // MARK: - Variables
    /// SwifterSwift: User’s current calendar.
    var calendar: Calendar {
        // Workaround to segfault on corelibs foundation https://bugs.swift.org/browse/SR-10147
        return Calendar(identifier: Calendar.current.identifier)
    }
    
    /// SwifterSwift: Era.
    ///
    ///        Date().era -> 1
    ///
    var era: Int {
        return calendar.component(.era, from: self)
    }
    
#if !os(Linux)
    /// SwifterSwift: Quarter.
    ///
    ///        Date().quarter -> 3 // date in third quarter of the year.
    ///
    var quarter: Int {
        let month = Double(calendar.component(.month, from: self))
        let numberOfMonths = Double(calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(ceil(month / numberOfMonthsInQuarter))
    }
#endif
    
    /// SwifterSwift: Week of year.
    ///
    ///        Date().weekOfYear -> 2 // second week in the year.
    ///
    var weekOfYear: Int {
        return calendar.component(.weekOfYear, from: self)
    }
    /// SwifterSwift: Week of month.
    ///
    ///        Date().weekOfMonth -> 3 // date is in third week of the month.
    ///
    var weekOfMonth: Int {
        return calendar.component(.weekOfMonth, from: self)
    }
    /// Set and get current year.
    var year: Int {
        get {
#if os(Linux)
            let calendar = Calendar(identifier: .gregorian)
#else
            let calendar = Calendar.autoupdatingCurrent
#endif
            
            return calendar.component(.year, from: self)
        }
        set {
            update(components: [.year: newValue])
        }
    }
    
    /// Set and get current month.
    var month: Int {
        get {
#if os(Linux)
            let calendar = Calendar(identifier: .gregorian)
#else
            let calendar = Calendar.autoupdatingCurrent
#endif
            
            return calendar.component(.month, from: self)
        }
        set {
            update(components: [.month: newValue])
        }
    }
    
    /// Set and get current day.
    var day: Int {
        get {
#if os(Linux)
            let calendar = Calendar(identifier: .gregorian)
#else
            let calendar = Calendar.autoupdatingCurrent
#endif
            
            return calendar.component(.day, from: self)
        }
        set {
            update(components: [.day: newValue])
        }
    }
    
    /// Set and get current hour.
    var hour: Int {
        get {
#if os(Linux)
            let calendar = Calendar(identifier: .gregorian)
#else
            let calendar = Calendar.autoupdatingCurrent
#endif
            
            return calendar.component(.hour, from: self)
        }
        set {
            update(components: [.hour: newValue])
        }
    }
    
    /// Set and get current minute.
    var minute: Int {
        get {
#if os(Linux)
            let calendar = Calendar(identifier: .gregorian)
#else
            let calendar = Calendar.autoupdatingCurrent
#endif
            
            return calendar.component(.minute, from: self)
        }
        set {
            update(components: [.minute: newValue])
        }
    }
    
    /// Set and get current second.
    var second: Int {
        get {
#if os(Linux)
            let calendar = Calendar(identifier: .gregorian)
#else
            let calendar = Calendar.autoupdatingCurrent
#endif
            
            return calendar.component(.second, from: self)
        }
        set {
            update(components: [.second: newValue])
        }
    }
    
    /// Get current nanosecond.
    var nanosecond: Int {
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        return calendar.component(.nanosecond, from: self)
    }
    
    /// Get the weekday number from
    /// - 1 - Sunday.
    /// - 2 - Monday.
    /// - 3 - Tuerday.
    /// - 4 - Wednesday.
    /// - 5 - Thursday.
    /// - 6 - Friday.
    /// - 7 - Saturday.
    var weekday: Int {
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        return calendar.component(.weekday, from: self)
    }
    
    /// SwifterSwift: Milliseconds.
    ///
    ///     Date().millisecond -> 68
    ///
    ///     var someDate = Date()
    ///     someDate.millisecond = 68 // sets someDate's nanosecond to 68000000.
    ///
    var millisecond: Int {
        get {
            return calendar.component(.nanosecond, from: self) / 1_000_000
        }
        set {
            let nanoSeconds = newValue * 1_000_000
#if targetEnvironment(macCatalyst)
            // The `Calendar` implementation in `macCatalyst` does not know that a nanosecond is 1/1,000,000,000th of a second
            let allowedRange = 0..<1_000_000_000
#else
            let allowedRange = calendar.range(of: .nanosecond, in: .second, for: self)!
#endif
            guard allowedRange.contains(nanoSeconds) else { return }
            
            if let date = calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }
    
    /// SwifterSwift: Check if date is in future.
    ///
    ///     Date(timeInterval: 100, since: Date()).isInFuture -> true
    ///
    var isInFuture: Bool {
        return self > Date()
    }
    
    /// SwifterSwift: Check if date is in past.
    ///
    ///     Date(timeInterval: -100, since: Date()).isInPast -> true
    ///
    var isInPast: Bool {
        return self < Date()
    }
    
    /// SwifterSwift: Check if date is within today.
    ///
    ///     Date().isInToday -> true
    ///
    var isInToday: Bool {
        return calendar.isDateInToday(self)
    }
    
    /// SwifterSwift: Check if date is within yesterday.
    ///
    ///     Date().isInYesterday -> false
    ///
    var isInYesterday: Bool {
        return calendar.isDateInYesterday(self)
    }
    
    /// SwifterSwift: Check if date is within tomorrow.
    ///
    ///     Date().isInTomorrow -> false
    ///
    var isInTomorrow: Bool {
        return calendar.isDateInTomorrow(self)
    }
    
    /// SwifterSwift: Check if date is within a weekend period.
    var isInWeekend: Bool {
        return calendar.isDateInWeekend(self)
    }
    
    /// SwifterSwift: Check if date is within a weekday period.
    var isWorkday: Bool {
        return !calendar.isDateInWeekend(self)
    }
    
    /// SwifterSwift: Check if date is within the current week.
    var isInCurrentWeek: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    /// SwifterSwift: Check if date is within the current month.
    var isInCurrentMonth: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .month)
    }
    
    /// SwifterSwift: Check if date is within the current year.
    var isInCurrentYear: Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
    /// SwifterSwift: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
    ///
    ///     Date().iso8601String -> "2017-01-12T14:51:29.574Z"
    ///
    var iso8601String: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: self).appending("Z")
    }
    
    /// SwifterSwift: Nearest five minutes to date.
    ///
    ///     var date = Date() // "5:54 PM"
    ///     date.minute = 32 // "5:32 PM"
    ///     date.nearestFiveMinutes // "5:30 PM"
    ///
    ///     date.minute = 44 // "5:44 PM"
    ///     date.nearestFiveMinutes // "5:45 PM"
    ///
    var nearestFiveMinutes: Date {
        var components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: self)
        let min = components.minute!
        components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }
    
    /// SwifterSwift: Nearest ten minutes to date.
    ///
    ///     var date = Date() // "5:57 PM"
    ///     date.minute = 34 // "5:34 PM"
    ///     date.nearestTenMinutes // "5:30 PM"
    ///
    ///     date.minute = 48 // "5:48 PM"
    ///     date.nearestTenMinutes // "5:50 PM"
    ///
    var nearestTenMinutes: Date {
        var components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: self)
        let min = components.minute!
        components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }
    
    /// SwifterSwift: Nearest quarter hour to date.
    ///
    ///     var date = Date() // "5:57 PM"
    ///     date.minute = 34 // "5:34 PM"
    ///     date.nearestQuarterHour // "5:30 PM"
    ///
    ///     date.minute = 40 // "5:40 PM"
    ///     date.nearestQuarterHour // "5:45 PM"
    ///
    var nearestQuarterHour: Date {
        var components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: self)
        let min = components.minute!
        components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }
    
    /// SwifterSwift: Nearest half hour to date.
    ///
    ///     var date = Date() // "6:07 PM"
    ///     date.minute = 41 // "6:41 PM"
    ///     date.nearestHalfHour // "6:30 PM"
    ///
    ///     date.minute = 51 // "6:51 PM"
    ///     date.nearestHalfHour // "7:00 PM"
    ///
    var nearestHalfHour: Date {
        var components = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute, .second, .nanosecond],
            from: self)
        let min = components.minute!
        components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        components.nanosecond = 0
        return calendar.date(from: components)!
    }
    
    /// SwifterSwift: Nearest hour to date.
    ///
    ///     var date = Date() // "6:17 PM"
    ///     date.nearestHour // "6:00 PM"
    ///
    ///     date.minute = 36 // "6:36 PM"
    ///     date.nearestHour // "7:00 PM"
    ///
    var nearestHour: Date {
        let min = calendar.component(.minute, from: self)
        let components: Set<Calendar.Component> = [.year, .month, .day, .hour]
        let date = calendar.date(from: calendar.dateComponents(components, from: self))!
        
        if min < 30 {
            return date
        }
        return calendar.date(byAdding: .hour, value: 1, to: date)!
    }
    
    /// SwifterSwift: Yesterday date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let yesterday = date.yesterday // "Oct 2, 2018, 10:57:11"
    ///
    
    /// SwifterSwift: Tomorrow's date.
    ///
    ///     let date = Date() // "Oct 3, 2018, 10:57:11"
    ///     let tomorrow = date.tomorrow // "Oct 4, 2018, 10:57:11"
    ///
    var tomorrow: Date {
        return calendar.date(byAdding: .day, value: 1, to: self) ?? Date()
    }
    
    /// SwifterSwift: UNIX timestamp from date.
    ///
    ///        Date().unixTimestamp -> 1484233862.826291
    ///
    var unixTimestamp: Double {
        return timeIntervalSince1970
    }
    // MARK: - Functions
    
    /// Update current Date components.
    ///
    /// - Parameters:
    ///   - components: Dictionary of components and values to be updated.
    mutating func update(components: [EditableDateComponents: Int]) {
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        var dateComponents = calendar.dateComponents([.year, .month, .day, .weekday, .hour, .minute, .second, .nanosecond], from: self)
        
        for (component, value) in components {
            switch component {
            case .year:
                dateComponents.year = value
                
            case .month:
                dateComponents.month = value
                
            case .day:
                dateComponents.day = value
                
            case .hour:
                dateComponents.hour = value
                
            case .minute:
                dateComponents.minute = value
                
            case .second:
                dateComponents.second = value
            }
        }
        
        guard let date = calendar.date(from: dateComponents) else {
            return
        }
        
        self = date
    }
}
// MARK: - Methods
 extension Date {
    
    /// 获取时间，根据当前日期时区
    /// - Returns: <#description#>
     func getCurrentDate() -> Date {
        let date = Date()
        let zone = TimeZone.current
        let localDate = date.addingTimeInterval(TimeInterval(zone.secondsFromGMT(for: date)))
        return localDate
    }
    /// Get the months number between self and another date.
    ///
    /// - Parameter toDate: The another date.
    /// - Returns: Returns the months between the two dates.
    func monthsBetween(_ toDate: Date) -> Int {
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        let components = calendar.dateComponents([.month], from: self, to: toDate)
        
        guard let month = components.month else {
            return 0
        }
        
        return abs(month)
    }
    
    /// Get the days number between self and another date.
    ///
    /// - Parameter anotherDate: The another date.
    /// - Returns: Returns the days between the two dates.
    func daysBetween(_ anotherDate: Date) -> Int {
        let time: TimeInterval = timeIntervalSince(anotherDate)
        return Int(abs(time / 60 / 60 / 24))
    }
    
    /// Returns if self is today.
    ///
    /// - Returns: Returns if self is today.
    func isToday() -> Bool {
        isSame(Date())
    }
    
    /// Compare self with another date.
    ///
    /// - Parameter anotherDate: The another date to compare as Date.
    /// - Returns: Returns true if is same day, otherwise false.
    func isSame(_ anotherDate: Date) -> Bool {
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        let componentsSelf = calendar.dateComponents([.year, .month, .day], from: self)
        let componentsAnotherDate = calendar.dateComponents([.year, .month, .day], from: anotherDate)
        
        return componentsSelf.year == componentsAnotherDate.year && componentsSelf.month == componentsAnotherDate.month && componentsSelf.day == componentsAnotherDate.day
    }
    
    /// Add days to
    ///
    /// - Parameter days: The number of days to add.
    /// - Returns: Returns self by adding the gived days number.
    func addingDays(_ days: Int) -> Date? {
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        return calendar.date(byAdding: .day, value: days, to: self)
    }
    /// Add Hour to
    ///
    /// - Parameter Hour: The number of Hour to add.
    /// - Returns: Returns self by adding the gived Hour number.
    func addingHour(_ hour: Int) -> Date? {
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        return calendar.date(byAdding: .hour, value: hour, to: self)
    }
    
    /// Add days to
    ///
    /// - Parameter days: The number of days to add.
    mutating func addDays(_ days: Int) {
        guard let date = addingDays(days) else {
            return
        }
        
        self = date
    }
    /// Add hour to
    ///
    /// - Parameter days: The number of days to add.
    mutating func addHour(_ hour: Int) {
        guard let date = addingHour(hour) else {
            return
        }
        self = date
    }
    
    /// Get the year string from
    ///
    /// - Returns: Returns the year string from
    func yearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        
        return dateFormatter.string(from: self)
    }
    
    /// Get the String date from
    ///
    /// - Parameters:
    ///   - format: Date format, default is "yyyy-MM-dd".
    ///   - locale: Locale, default is "en_US_POSIX".
    /// - Returns: Returns the String data from
    func dateString(format: String = "yyyy-MM-dd", locale: String = "en_US_POSIX") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    /// Returns date with the year, month and day only.
    ///
    /// - Returns: Date after removing all components but not year, month and day.
    func shortDate() -> Date {
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        
        guard let date = calendar.date(from: components) else {
            return self
        }
        
        return date
    }
    
    /// Check if the given date is less than
    ///
    /// - Parameter date: Date to compare.
    /// - Returns: Returns a true if self is greater than another one, otherwise false.
    func isGreaterThan(_ date: Date) -> Bool {
        var isGreater = false
        if compare(date) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        return isGreater
    }
    
    /// Check if the given date is greater than
    ///
    /// - Parameter date: Date to compare.
    /// - Returns: Returns a true if self is less than another one, otherwise false.
    func isLessThan(_ date: Date) -> Bool {
        var isLess = false
        if compare(date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        return isLess
    }
    
    /// Just an alias for `isSame(_ anotherDate: Date)`.
    ///
    /// - Parameter date: Date to compare.
    /// - Returns: Returns a true if self is equal to another one, otherwise false.
    func isEqual(_ date: Date) -> Bool {
        isSame(date)
    }
    
    /// Create a Date with the yesterday date.
    ///
    /// - Returns: Returns a Date with the yesterday date.
    func yesterday() -> Date {
        var date = self
        date.day -= 1
        
        return date
    }
    
    /// Get weekday as a localized string from current weekday number.
    ///
    /// - Returns: Return weekday as a localized string.
    func localizedWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        if let locale = NSLocale.preferredLanguages.first {
            dateFormatter.locale = Locale(identifier: locale)
        }
        
        return dateFormatter.string(from: self).capitalized
    }
    
    /// Get month as a localized string from current month.
    ///
    /// - Returns: Returns the given month as a localized string.
    func localizedMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        if let locale = NSLocale.preferredLanguages.first {
            dateFormatter.locale = Locale(identifier: locale)
        }
        
        return dateFormatter.string(from: self).capitalized
    }
    
    /// Get the given Date structure as a formatted string.
    ///
    /// - Parameters:
    ///   - info: The Date to be formatted.
    ///   - dateSeparator: The string to be used as date separator. (Currently does not work on Linux).
    ///   - usFormat: Set if the timestamp is in US format or not.
    ///   - nanosecond: Set if the timestamp has to have the nanosecond.
    /// - Returns: Returns a String in the following format (dateSeparator = "/", usFormat to false and nanosecond to false). D/M/Y H:M:S. Example: 15/10/2013 10:38:43.
    func description(dateSeparator: String = "/", usFormat: Bool = false, nanosecond: Bool = false) -> String {
        var description: String
        
#if os(Linux)
        if usFormat {
            description = String(format: "%04li-%02li-%02li %02li:%02li:%02li", year, month, day, hour, minute, second)
        } else {
            description = String(format: "%02li-%02li-%04li %02li:%02li:%02li", month, day, year, hour, minute, second)
        }
#else
        if usFormat {
            description = String(format: "%04li%@%02li%@%02li %02li:%02li:%02li", year, dateSeparator, month, dateSeparator, day, hour, minute, second)
        } else {
            description = String(format: "%02li%@%02li%@%04li %02li:%02li:%02li", month, dateSeparator, day, dateSeparator, year, hour, minute, second)
        }
#endif
        
        if nanosecond {
            description += String(format: ":%03li", self.nanosecond / 1_000_000)
        }
        
        return description
    }
    /// SwifterSwift: Date by adding multiples of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of components to add.
    /// - Returns: original date + multiples of component added.
    func adding(_ component: Calendar.Component, value: Int) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self)
    }
    
    /// SwifterSwift: Add calendar component to date.
    ///
    ///     var date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of component to add.
    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }
    
    // swiftlint:enable function_body_length
    
    /// SwifterSwift: Check if date is in current given calendar component.
    ///
    ///     Date().isInCurrent(.day) -> true
    ///     Date().isInCurrent(.year) -> true
    ///
    /// - Parameter component: calendar component to check.
    /// - Returns: true if date is in current given calendar component.
    func isInCurrent(_ component: Calendar.Component) -> Bool {
        return calendar.isDate(self, equalTo: Date(), toGranularity: component)
    }

    /// SwifterSwift: get number of seconds between two date
    ///
    /// - Parameter date: date to compare self to.
    /// - Returns: number of seconds between self and given date.
    func secondsSince(_ date: Date) -> Double {
        return timeIntervalSince(date)
    }
    
    /// SwifterSwift: get number of minutes between two date
    ///
    /// - Parameter date: date to compare self to.
    /// - Returns: number of minutes between self and given date.
    func minutesSince(_ date: Date) -> Double {
        return timeIntervalSince(date) / 60
    }
    
    /// SwifterSwift: get number of hours between two date
    ///
    /// - Parameter date: date to compare self to.
    /// - Returns: number of hours between self and given date.
    func hoursSince(_ date: Date) -> Double {
        return timeIntervalSince(date) / 3600
    }
    
    /// SwifterSwift: get number of days between two date
    ///
    /// - Parameter date: date to compare self to.
    /// - Returns: number of days between self and given date.
    func daysSince(_ date: Date) -> Double {
        return timeIntervalSince(date) / (3600 * 24)
    }
    
    /// SwifterSwift: check if a date is between two other dates.
    ///
    /// - Parameters:
    ///   - startDate: start date to compare self to.
    ///   - endDate: endDate date to compare self to.
    ///   - includeBounds: true if the start and end date should be included (default is false).
    /// - Returns: true if the date is between the two given dates.
    func isBetween(_ startDate: Date, _ endDate: Date, includeBounds: Bool = false) -> Bool {
        if includeBounds {
            return startDate.compare(self).rawValue * compare(endDate).rawValue >= 0
        }
        return startDate.compare(self).rawValue * compare(endDate).rawValue > 0
    }
    
    /// SwifterSwift: check if a date is a number of date components of another date.
    ///
    /// - Parameters:
    ///   - value: number of times component is used in creating range.
    ///   - component: Calendar.Component to use.
    ///   - date: Date to compare self to.
    /// - Returns: true if the date is within a number of components of another date.
    func isWithin(_ value: UInt, _ component: Calendar.Component, of date: Date) -> Bool {
        let components = calendar.dateComponents([component], from: self, to: date)
        let componentValue = components.value(for: component)!
        return abs(componentValue) <= value
    }
    
    /// SwifterSwift: Returns a random date within the specified range.
    ///
    /// - Parameter range: The range in which to create a random date. `range` must not be empty.
    /// - Returns: A random date within the bounds of `range`.
    static func random(in range: Range<Date>) -> Date {
        return Date(timeIntervalSinceReferenceDate:
                        TimeInterval
                        .random(in: range.lowerBound.timeIntervalSinceReferenceDate..<range.upperBound
                                    .timeIntervalSinceReferenceDate))
    }
    
    /// SwifterSwift: Returns a random date within the specified range.
    ///
    /// - Parameter range: The range in which to create a random date.
    /// - Returns: A random date within the bounds of `range`.
    static func random(in range: ClosedRange<Date>) -> Date {
        return Date(timeIntervalSinceReferenceDate:
                        TimeInterval
                        .random(in: range.lowerBound.timeIntervalSinceReferenceDate...range.upperBound
                                    .timeIntervalSinceReferenceDate))
    }
    
    /// SwifterSwift: Returns a random date within the specified range, using the given generator as a source for randomness.
    ///
    /// - Parameters:
    ///   - range: The range in which to create a random date. `range` must not be empty.
    ///   - generator: The random number generator to use when creating the new random date.
    /// - Returns: A random date within the bounds of `range`.
    static func random<T>(in range: Range<Date>, using generator: inout T) -> Date where T: RandomNumberGenerator {
        return Date(timeIntervalSinceReferenceDate:
                        TimeInterval.random(
                            in: range.lowerBound.timeIntervalSinceReferenceDate..<range.upperBound.timeIntervalSinceReferenceDate,
                            using: &generator))
    }
    
    /// SwifterSwift: Returns a random date within the specified range, using the given generator as a source for randomness.
    ///
    /// - Parameters:
    ///   - range: The range in which to create a random date.
    ///   - generator: The random number generator to use when creating the new random date.
    /// - Returns: A random date within the bounds of `range`.
    static func random<T>(in range: ClosedRange<Date>, using generator: inout T) -> Date
    where T: RandomNumberGenerator {
        return Date(timeIntervalSinceReferenceDate:
                        TimeInterval.random(
                            in: range.lowerBound.timeIntervalSinceReferenceDate...range.upperBound.timeIntervalSinceReferenceDate,
                            using: &generator))
    }
}
// MARK: - Initializers
 extension Date {
    /// Creates a Date object from year, month and day as Int.
    ///
    /// - Parameters:
    ///   - year: Year.
    ///   - month: Month.
    ///   - day: Day.
    ///   - hour: Hour.
    ///   - minute: Minute.
    ///   - second: Second.
    init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        guard let date = calendar.date(from: components) else {
            return nil
        }
        self = date
    }
    
    /// Creates a Date object from a date String in a given format.
    ///
    /// - Parameters:
    ///   - dateString: Date String.
    ///   - format: Date String format. Default is "yyyy-MM-dd". Example: "2014-05-20".
    ///   - locale: Locale, default is "en_US_POSIX". You can use Locale.current.identifier.
    init?(parse dateString: String, format: String = "yyyy-MM-dd", locale: String = "en_US_POSIX") {
#if os(Linux)
        let calendar = Calendar(identifier: .gregorian)
#else
        let calendar = Calendar.autoupdatingCurrent
#endif
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        guard let parsed = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        self = parsed
    }
    /// Creates a Date object from a date String in a given format.
    ///
    /// - Parameters:
    ///   - dateString: Date String.
    ///   - format: Date String format. Default is "yyyy-MM-dd". Example: "2014-05-20".
    ///   - locale: Locale, default is "en_US_POSIX". You can use Locale.current.identifier.
    init?(parse dateString: String, format: String = "yyyy-MM-dd HH:mm:ss") {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        guard let parsed = dateFormatter.date(from: dateString) else {
            return nil
        }
        self = parsed
    }
    /// Create a Date with other two Date objects.
    /// Taken from the first date: day, month and year.
    /// Taken from the second date: hours and minutes.
    ///
    /// - Parameters:
    ///   - date: The first date for date.
    ///   - time: The second date for time.
    ///   - dateSeparator: Date separator, default is "-".
    ///   - timeSeparator: Time separator, default is ":".
    init?(date: Date, time: Date, dateSeparator: String = "-", timeSeparator: String = ":") {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy\(dateSeparator)MM\(dateSeparator)dd"
        let datePortion: String = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "HH\(timeSeparator)mm"
        let timePortion: String = dateFormatter.string(from: time)
        
        let dateTime = "\(datePortion) \(timePortion)"
        dateFormatter.dateFormat = "yyyy\(dateSeparator)MM\(dateSeparator)dd HH\(timeSeparator)mm"
        
        guard let parsed = dateFormatter.date(from: dateTime) else {
            return nil
        }
        self = parsed
    }
    
    /// Create an ISO 8601 date from a String.
    ///
    /// - Parameter date: ISO 8601 String.
    init?(iso8601: String) {
        guard let date = Date(parse: iso8601, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ") else {
            return nil
        }
        
        self = date
    }
    
#if !os(Linux)
    /// Creates an ISO 8601 String form
    ///
    /// - Returns: Returns an ISO 8601 String form
    func iso8601() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        
        return dateFormatter.string(from: self)
    }
#endif
    
}
#endif
