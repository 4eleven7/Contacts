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
	
	@IBOutlet var filter: UISegmentedControl!
	
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
	
	func includeNonImportant() -> Bool
	{
		return filter.selectedSegmentIndex == 0
	}
	
	// MARK: IBActions
	
	@IBAction func switchFilters()
	{
		tableView.reloadData()
	}
	
	// MARK: UITableViewDataSource
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return contacts.numberOfContacts(showNonImportant: includeNonImportant())
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier("ContactTableCell") as! ContactTableCell
		
		let contact = contacts.contactAtIndex(indexPath.row, includeNonImportant: includeNonImportant())
		cell.contactNameLabel?.text = contact.name
		
		var isWeekend = contact.created!.isWeekend()
		var isDaytime = contact.created!.isBetweenTime()
		var timeStringTest = "\(contact.created!) weekend \(isWeekend) isDaytime \(isDaytime)"
		cell.dateTextLabel?.text = timeStringTest
		
		cell.contactMethodOne?.hidden = contact.phone?.count == 0
		cell.contactMethodTwo?.hidden = contact.email?.count == 0
		
		return cell
	}
	
	
	// MARK: UITableViewDelegate
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		let contact = contacts.contactAtIndex(indexPath.row, includeNonImportant: includeNonImportant())
		
		let personViewController = helper.getViewControllerForContact(contact.id)
		navigationController?.pushViewController(personViewController, animated: true)
	}
}
