//
//  ContactObject.swift
//  Contacts
//
//  Created by Daniel Love on 07/05/2015.
//  Copyright (c) 2015 Daniel Love. All rights reserved.
//

import Foundation
import AddressBook

struct Contact: Printable
{
	var id: ABRecordID = (-1)
	var name: String = ""
	
	// Can be mutliple values
	var phone: [String]?
	var email: [String]?
	
	var created: NSDate?
	var modified: NSDate?
	
	var description: String {
		return "Contact: \(name) ✉️:\(phone?.count) 📞:\(email?.count) created: \(created) modified: \(modified)"
	}
}
