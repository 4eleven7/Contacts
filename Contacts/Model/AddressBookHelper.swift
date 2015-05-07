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
}
