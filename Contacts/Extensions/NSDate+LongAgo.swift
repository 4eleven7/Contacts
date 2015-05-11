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
	
}
