//
//  ContactTableCell.swift
//  Contacts
//
//  Created by Daniel Love on 11/05/2015.
//  Copyright (c) 2015 Daniel Love. All rights reserved.
//

import UIKit

class ContactTableCell: UITableViewCell
{
	@IBOutlet var contactNameLabel: UILabel?
	@IBOutlet var dateTextLabel: UILabel?
	@IBOutlet var contactMethodOne: UIButton?
	@IBOutlet var contactMethodTwo: UIButton?
	
	var contactMethods: (hasPhone: Bool, hasEmail: Bool) = (false, false) {
		didSet {
			updateContactMethods()
		}
	}
	
	func updateContactMethods()
	{
		contactMethodOne?.hidden = true
		contactMethodTwo?.hidden = true
		
		if contactMethods.hasPhone
		{
			contactMethodOne?.hidden = false
			contactMethodOne?.setTitle("📞", forState: UIControlState.Normal)
		}
		
		if contactMethods.hasEmail
		{
			if let button: UIButton? = { if self.contactMethods.hasPhone { return self.contactMethodTwo } else { return self.contactMethodOne } }()
			{
				button?.hidden = false
				button?.setTitle("✉️", forState: UIControlState.Normal)
			}
		}
	}
}
