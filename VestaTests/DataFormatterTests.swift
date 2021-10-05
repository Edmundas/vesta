//
//  DataFormatterTests.swift
//  VestaTests
//
//  Created by Edmundas Matusevicius on 2021-09-30.
//

import XCTest
@testable import Vesta

class DataFormatterTests: XCTestCase {
    
    var monthDayFormatter: DateFormatter?
    var hourMinuteFormatter: DateFormatter?
    var timeIntervalFormatter: DateIntervalFormatter?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        monthDayFormatter = DateFormatter()
        monthDayFormatter!.setLocalizedDateFormatFromTemplate("MMdd")
        
        hourMinuteFormatter = DateFormatter()
        hourMinuteFormatter!.setLocalizedDateFormatFromTemplate("HHmm")
        
        timeIntervalFormatter = DateIntervalFormatter()
        timeIntervalFormatter!.dateTemplate = "HHmm"
    }
    
    override func tearDownWithError() throws {
        timeIntervalFormatter = nil
        hourMinuteFormatter = nil
        monthDayFormatter = nil
        try super.tearDownWithError()
    }
    
    // MARK: Tests
    
    func testFormattedDurationWhenStartDateIsLaterThanEndDate() throws {
        let startDate = Date(timeIntervalSinceReferenceDate: 0.0)
        let endDate = Date(timeIntervalSinceReferenceDate: -90.0)
        
        XCTAssertEqual(DataFormatter.formattedDuration(startDate: startDate, endDate: endDate), "-")
    }
    
    func testFormattedDurationWhenStartDateIsEqualEndDate() throws {
        let startDate = Date()
        let endDate = startDate
        
        XCTAssertEqual(DataFormatter.formattedDuration(startDate: startDate, endDate: endDate), "00:00:00")
    }
    
    func testFormattedDurationWhenStartDateIsEarlierThanEndDate() throws {
        let startDate = Date(timeIntervalSinceReferenceDate: 0.0)
        let endDate = Date(timeIntervalSinceReferenceDate: 90.0)
        
        XCTAssertEqual(DataFormatter.formattedDuration(startDate: startDate, endDate: endDate), "00:01:30")
    }
    
    func testFormattedDurationForNegtive() throws {
        let duration = -90.0
        
        XCTAssertEqual(DataFormatter.formattedDuration(duration: duration), "00:00:00")
    }
    
    func testFormattedDurationForZero() throws {
        let duration = 0.0
        
        XCTAssertEqual(DataFormatter.formattedDuration(duration: duration), "00:00:00")
    }
    
    func testFormattedDurationForPositive() throws {
        let duration = 90.0
        
        XCTAssertEqual(DataFormatter.formattedDuration(duration: duration), "00:01:30")
    }
    
    func testFormattedMonthDay() throws {
        let date = Date(timeIntervalSinceReferenceDate: 0.0)
        
        XCTAssertEqual(DataFormatter.formattedMonthDay(date: date), monthDayFormatter!.string(from: date))
    }
    
    func testFormattedHourMinute() throws {
        let date = Date(timeIntervalSinceReferenceDate: 5400.0)
        
        XCTAssertEqual(DataFormatter.formattedHourMinute(date: date), hourMinuteFormatter!.string(from: date))
    }
    
    func testFormattedTimeIntervalWhenStartDateIsLaterThanEndDate() throws {
        let startDate = Date(timeIntervalSinceReferenceDate: 0.0)
        let endDate = Date(timeIntervalSinceReferenceDate: -90.0)
        
        XCTAssertEqual(DataFormatter.formattedTimeInterval(startDate: startDate, endDate: endDate), timeIntervalFormatter!.string(from: startDate, to: endDate))
    }
    
    func testFormattedTimeIntervalWhenStartDateIsEqualEndDate() throws {
        let startDate = Date()
        let endDate = startDate
        
        XCTAssertEqual(DataFormatter.formattedTimeInterval(startDate: startDate, endDate: endDate), timeIntervalFormatter!.string(from: startDate, to: endDate))
    }
    
    func testFormattedTimeIntervalWhenStartDateIsEarlierThanEndDate() throws {
        let startDate = Date(timeIntervalSinceReferenceDate: 0.0)
        let endDate = Date(timeIntervalSinceReferenceDate: 90.0)
        
        XCTAssertEqual(DataFormatter.formattedTimeInterval(startDate: startDate, endDate: endDate), timeIntervalFormatter!.string(from: startDate, to: endDate))
    }
    
}
