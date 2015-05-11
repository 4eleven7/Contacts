//
//  NSDate+LongAgo.swift
//  Contacts
//
//  Created by Daniel Love on 07/05/2015.
//  Copyright (c) 2015 Daniel Love. All rights reserved.
//

import Foundation

extension NSDate
{
	// MARK: Comparisons
	
	func isWeekend() -> Bool
	{
		let calendar: NSCalendar = NSCalendar.currentCalendar()
		return calendar.isDateInWeekend(self)
	}
	
	func isBetweenTime(start:Int = 9, end: Int = 17) -> Bool
	{
		let calendar: NSCalendar = NSCalendar.currentCalendar()
		let components  = calendar.components(NSCalendarUnit.CalendarUnitHour, fromDate: self)
		
		return components.hour > start && components.hour < end
	}
	
	func isSameWeekAsDate(date: NSDate) -> Bool
	{
		let calendar: NSCalendar = NSCalendar.currentCalendar()
		return calendar.isDate(self, equalToDate: date, toUnitGranularity: NSCalendarUnit.CalendarUnitWeekOfYear)
	}
	
	func isLastWeek() -> Bool
	{
		let dayFlags: NSCalendarUnit = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekday
		let calendar: NSCalendar = NSCalendar.currentCalendar()
		
		var components: NSDateComponents = calendar.components(dayFlags, fromDate: NSDate())
		components.hour = 0
		components.minute = 0
		components.second = 0
		components.day -= 8
		
		var referenceDate: NSDate = calendar.dateFromComponents(components)!
		return self.compare(referenceDate) == NSComparisonResult.OrderedDescending
	}
}
