//
//  ContactsController.swift
//  Contacts
//
//  Created by Daniel Love on 07/05/2015.
//  Copyright (c) 2015 Daniel Love. All rights reserved.
//

import UIKit
import AddressBook

class ContactsController
{
	var objects: [Contact] = [Contact]()
	var importantCache: [ABRecordID] = [ABRecordID]()
	
	var startOfDayTime: Int = 8
	var endOfDayTime: Int = 18
	
	func updateContacts(contacts: [Contact])
	{
		// Sort by date
		objects = contacts.sorted {
			return $0.created?.timeIntervalSince1970 > $1.created?.timeIntervalSince1970
		}
		
		for contact in objects
		{
			if let createdDate = contact.created
			{
				let isWeekend = createdDate.isWeekend()
				let isDaytime = createdDate.isBetweenTime(start: startOfDayTime, end: endOfDayTime)
				
				if isWeekend {
					importantCache.append(contact.id)
				}
				else if !isDaytime {
					importantCache.append(contact.id)
				}
			}
		}
	}
	
	func numberOfContacts(showNonImportant: Bool = true) -> Int
	{
		if showNonImportant {
			return objects.count
		}
		
		return importantCache.count
	}
	
	func contactAtIndex(index: Int, includeNonImportant: Bool = true) -> Contact
	{
		if includeNonImportant {
			return objects[index]
		}
		
		let contactId = importantCache[index]
		var contacts = objects.filter { $0.id == contactId }
		
		return contacts.first!
	}
}
