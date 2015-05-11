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
	
	var hasPhone: Bool = false {
		didSet {
			updateContactMethods()
		}
	}
	var hasEmail: Bool = false {
		didSet {
			updateContactMethods()
		}
	}
	
	func updateContactMethods()
	{
		if hasPhone {
			contactMethodOne?.setTitle("📞", forState: UIControlState.Normal)
			
			if hasEmail {
				contactMethodTwo?.setTitle("✉️", forState: UIControlState.Normal)
			}
		}
		else if hasEmail {
			contactMethodOne?.setTitle("✉️", forState: UIControlState.Normal)
		}
		
		contactMethodOne?.hidden = !(hasPhone || hasEmail)
		contactMethodTwo?.hidden = !(hasPhone && hasEmail)
	}
}
