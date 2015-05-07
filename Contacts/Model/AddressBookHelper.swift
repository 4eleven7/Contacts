//
//  AddressBookHelper.swift
//  Contacts
//
//  Created by Daniel Love on 07/05/2015.
//  Copyright (c) 2015 Daniel Love. All rights reserved.
//

import Foundation
import AddressBook
import AddressBookUI

class AddressBookHelper
{
	var addressBook: ABAddressBookRef? =
	{
		var error: Unmanaged<CFErrorRef>?
		var addressBook: ABAddressBookRef? = ABAddressBookCreateWithOptions(nil, &error)?.takeRetainedValue()
		
		if (error != nil) {
			println("error occuring creating address book \(error)")
		}
		
		return addressBook
	}()
	
	func checkAuthorizationStatus() -> Bool
	{
		var error: Unmanaged<CFErrorRef>?
		var authorised: Bool = false
		
		if addressBook != nil
		{
			let authStatus = ABAddressBookGetAuthorizationStatus()
			if authStatus == ABAuthorizationStatus.NotDetermined || authStatus == ABAuthorizationStatus.Authorized
			{
				// Semaphore lock is used to wait until we get a response from the OS or user (via permission dialogue).
				var lock = dispatch_semaphore_create(0)
				ABAddressBookRequestAccessWithCompletion(addressBook,
				{ (success, error) in
					authorised = success && (error == nil)
					dispatch_semaphore_signal(lock)
				})
				dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER)
			}
		}
		
		return authorised
	}
	
	func getContacts() -> [Contact]
	{
		var allPeople: NSArray = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
		var contacts = [Contact]()
		
		for record in allPeople
		{
			var contact = createContact(record)
			contacts.append(contact)
		}
		
		return contacts
	}
	
	func createContact(record: ABRecordRef) -> Contact
	{
		var contact: Contact = Contact()
		contact.id = ABRecordGetRecordID(record)
		
		// Composite returns a concatenated value of multiple properties, such as prefix, suffix, first and last name.
		// As a backup we construct our own, using first and/or last name.
		if let name = ABRecordCopyCompositeName(record)?.takeRetainedValue() as? String
		{
			contact.name = name as String
		}
		else
		{
			var firstName = ABRecordCopyValue(record, kABPersonFirstNameProperty)?.takeRetainedValue() as? String
			var lastName = ABRecordCopyValue(record, kABPersonFirstNameProperty)?.takeRetainedValue() as? String
			contact.name = (firstName == nil ? "" : firstName!) + (lastName == nil ? "" : lastName!)
		}
		
		var createdDate = ABRecordCopyValue(record, kABPersonCreationDateProperty)?.takeRetainedValue() as? NSDate
		contact.created = createdDate
		
		var modifiedDate = ABRecordCopyValue(record, kABPersonModificationDateProperty)?.takeRetainedValue() as? NSDate
		contact.modified = modifiedDate
		
		return contact
	}
}
