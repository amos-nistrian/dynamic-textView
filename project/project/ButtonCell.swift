//
//  ButtonCell.swift
//  project
//

import UIKit

class ButtonCell: UITableViewCell {
	
	// tell the delegate to have this protocol called
	weak var delegate: ButtonCellDelegate?
	
	var btnInSection: Int!
	
	@IBOutlet weak var button: UIButton! {
		didSet {
			button.contentHorizontalAlignment = .left
			button.tintColor = UIColor(red:0.93, green:0.12, blue:0.14, alpha:1.0)
		}
	}

	
	@IBAction func buttonPressed(_ sender: Any) {
		
		// in the list of functions in the delegates protocol call this function
		delegate?.shouldAddCellInSection(section: btnInSection)
	}
	
	
}
