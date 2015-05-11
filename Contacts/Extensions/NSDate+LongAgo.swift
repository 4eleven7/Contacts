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
	
	// MARK: To string
	
	func dateString() -> String
	{
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "dd MMM HH:mm"
		return dateFormatter.stringFromDate(self)
	}
	
	func friendlyDayString() -> String
	{
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "EEEE"
		return dateFormatter.stringFromDate(self)
	}
	
	func toHumanisedString() -> String
	{
		let dayFlags: NSCalendarUnit = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekday
		let hourFlags: NSCalendarUnit = NSCalendarUnit.CalendarUnitHour
		let calendar: NSCalendar = NSCalendar.currentCalendar()
		
		// Is today?
		if calendar.isDateInToday(self)
		{
			let hourComponent = calendar.components(hourFlags, fromDate: self)
			if hourComponent.hour < 4 {
				return NSLocalizedString("Last night", comment: "Date added between midnight and 4am")
			}
			else if hourComponent.hour > 4 && hourComponent.hour < 8 {
				return NSLocalizedString("This morning", comment: "Date added after 4am, before 8am")
			}
			else {
				return NSLocalizedString("Today", comment: "Date added after 8am")
			}
		}
		
		// Was it Yesterday?
		if calendar.isDateInYesterday(self)
		{
			let hourComponent = calendar.components(hourFlags, fromDate: self)
			if hourComponent.hour > 20 {
				return NSLocalizedString("Last night", comment: "Date added after 8pm yesterday")
			}
			else if hourComponent.hour > 4 && hourComponent.hour < 8 {
				return NSLocalizedString("Yesterday morning", comment: "Date added after 4am, before 8am yesterday")
			}
			else {
				return NSLocalizedString("Yesterday", comment: "Date added after 8am yesterday")
			}
		}
		
		// Was it this week?
		if self.isSameWeekAsDate(NSDate())
		{
			return self.friendlyDayString()
		}
		
		// Was it last week?
		if self.isLastWeek()
		{
			return NSLocalizedString("Last %@", value: self.friendlyDayString(), comment: "A day last week, last {day name}, Last thursday")
		}
		
		return self.dateString()
	}
}
