//
//  MasterViewController.swift
//  Contacts
//
//  Created by Daniel Love on 07/05/2015.
//  Copyright (c) 2015 Daniel Love. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

class MasterViewController: UITableViewController
{
	var helper: AddressBookHelper = AddressBookHelper()
	var contacts: ContactsController = ContactsController()
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
	}

	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		retrieveContacts()
	}
	
	// MARK: Address Book
	
	func retrieveContacts()
	{
		if helper.checkAuthorizationStatus()
		{
			let objects = helper.getContacts()
			contacts.updateContacts(objects)
		}
		else
		{
			requirePermissionPrompt()
		}
	}
	
	func requirePermissionPrompt()
	{
		// TODO contacts permission settings prompt
	}
	
	// MARK: UITableViewDataSource
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return contacts.numberOfContacts(showNonImportant: false)
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as! UITableViewCell
		
		let contact = contacts.contactAtIndex(indexPath.row, includeNonImportant: false)
		cell.textLabel?.text = contact.name
		
		var isWeekend = contact.created!.isWeekend()
		var isDaytime = contact.created!.isBetweenTime()
		var timeStringTest = "weekend \(isWeekend) isDaytime \(isDaytime)"
		cell.detailTextLabel?.text = timeStringTest
		
		return cell
	}
	
	// MARK: UITableViewDelegate
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		let contact = contacts.contactAtIndex(indexPath.row, includeNonImportant: false)
		
		let personViewController = helper.getViewControllerForContact(contact.id)
		navigationController?.pushViewController(personViewController, animated: true)
	}
}
