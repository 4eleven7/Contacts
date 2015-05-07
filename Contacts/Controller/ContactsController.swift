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
	
	func updateContacts(contacts: [Contact])
	{
		// Sort by date
		objects = contacts.sorted {
			return $0.created?.timeIntervalSince1970 > $1.created?.timeIntervalSince1970
		}
	}
	
	func numberOfContacts(showNonImportant: Bool = true) -> Int
	{
		return objects.count
	}
	
	func contactAtIndex(index: Int, includeNonImportant: Bool = true) -> Contact
	{
		return objects[index]
	}
}
