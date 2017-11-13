//
//  TextViewCell.swift
//  project
//

import UIKit


class TextViewCell: UITableViewCell, UITextViewDelegate {
	
	let greyTextColor = UIColor(red:0.47, green:0.47, blue:0.44, alpha:1.0)
	let lightGreyBackgroundColor =  UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
	let darkerGreyBackgroundColor = UIColor(red:0.77, green:0.77, blue:0.77, alpha:1.0)
	
	var delegate: ExpandingCellDelegate!
	
	var cellIndexPath: IndexPath!
	
	@IBOutlet weak var textHeightConstraint: NSLayoutConstraint!
		
	
	@IBOutlet weak var label: UILabel! {
		didSet {
			label.font = UIFont.systemFont(ofSize: 15)
			label.textColor = UIColor.lightGray
		}
	}
	
	@IBOutlet weak var textView: UITextView! {
		didSet {
			//textView.backgroundColor = darkerGreyBackgroundColor
			textView.backgroundColor = UIColor.brown
			textView.textColor = greyTextColor
			textView.layer.cornerRadius = 5
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.textView.delegate = self
	}
	
	// hide the keyboard when the user presses done on the keyboard
	// Also resizes the textview
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		
		print("Content Height \(self.textView.contentSize.height) ")
		print("Constraint is", self.textHeightConstraint.constant )
		
		if(self.textView.contentSize.height < self.textHeightConstraint.constant) {
			self.textView.isScrollEnabled = false
		} else {
			self.textView.isScrollEnabled = true
		}
		
		if (text == "\n") {
			textView.resignFirstResponder()
			return false
		}
		
		self.delegate.updateArray(self.cellIndexPath, text: textView.text)
		self.delegate.updateCellHeight(self.cellIndexPath, comment: textView.text)
		return true
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		textView.backgroundColor = UIColor.cyan
		textView.textColor = UIColor.black
	}
	
	// hide the keyboard if the user taps somewhere else
	func textViewDidEndEditing(_ textView: UITextView) {
		textView.backgroundColor = lightGreyBackgroundColor
		textView.textColor = greyTextColor
		textView.resignFirstResponder()
		self.delegate.updateArray(self.cellIndexPath, text: textView.text)
	}
	
} // EOC
