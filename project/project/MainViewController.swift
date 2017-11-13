//
//  ViewController.swift
//  project
//
//  Created by Amos  on 11/9/17.
//  Copyright © 2017 Amos . All rights reserved.
//

import UIKit

protocol ButtonCellDelegate: class {
	func shouldAddCellInSection(section: Int)
}

protocol ExpandingCellDelegate: class {
	func updateCellHeight(_ indexPath: IndexPath, comment: String)
	func updateArray(_ indexPath: IndexPath, text: String)
}

class MainViewController: UITableViewController, ExpandingCellDelegate, ButtonCellDelegate {

	var steps = [String]()
	var ingredients = [String]()
	
	let redColor = UIColor(red:0.93, green:0.12, blue:0.14, alpha:1.0)

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.separatorStyle = .none // remove lines between cells
		self.tableView.allowsSelection = false // remove highlighting when selecting a cell
		
	}
	
	
	//////* tableview delegate stuff below here *///////////////////////////////////////////////////////////////////////////////
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		var headers : [String] = ["Ingredients", "Steps"]
		return headers[section]
	}
	
	override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		
		if let header = view as? UITableViewHeaderFooterView {
			header.textLabel?.textColor = UIColor.black
			header.backgroundView?.backgroundColor  = UIColor.red.withAlphaComponent(0.35)
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch(section) {
		case 0:
			return ingredients.count + 1 // plus one for the button
		case 1 :
			return steps.count + 1 // plus one for the button
		default:
			return 0;
		}
	}
	
	
	// To enable self-sizing table view cells
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return UITableViewAutomaticDimension
	}
	
	// To enable self-sizing table view cells
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return UITableViewAutomaticDimension
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let section = indexPath.section
		let row = indexPath.row
		
		switch (section) {
	
		case 0:
			if (row == 0) {
				let cell = tableView.dequeueReusableCell(withIdentifier: "Button Cell", for: indexPath) as! ButtonCell
				
				cell.delegate = self as ButtonCellDelegate
				
				cell.button.setTitle("+ Ingredient     ", for: .normal)

				cell.btnInSection = section
				cell.button.tag = 0
				
				return cell
			} else {
				
				let cell = tableView.dequeueReusableCell(withIdentifier: "Picker Text View Cell", for: indexPath) as! PickerTextViewCell
				
				cell.delegate = self as ExpandingCellDelegate
				
				cell.cellIndexPath = indexPath
				print(cell.textView)
				cell.textView.text = ingredients[row-1]
				
				return cell
			}
			
		case 1:
			if (row == 0) {
				let cell = tableView.dequeueReusableCell(withIdentifier: "Button Cell", for: indexPath) as! ButtonCell
				
				cell.delegate = self as ButtonCellDelegate
				
				cell.button.setTitle("+ Step     ", for: .normal)
				cell.btnInSection = section
				cell.button.tag = 1
				
				return cell
			} else {
				
				let cell = tableView.dequeueReusableCell(withIdentifier: "Text View Cell", for: indexPath) as! TextViewCell
				
				cell.delegate = self as ExpandingCellDelegate

				cell.textView.text = steps[row-1]
				cell.cellIndexPath = indexPath
				return cell
			}
			
		default:
			let cell = tableView.dequeueReusableCell(withIdentifier: "Text View Cell", for: indexPath) as! TextViewCell
			return cell
		}
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	func shouldAddCellInSection(section: Int) {

		// Update the data source
		if (section == 0) {
			ingredients.append("")
		} else {
			steps.append("")
		}

		let row = tableView.numberOfRows(inSection: section)


		let indexPath = IndexPath(row: row, section: section)

		tableView.reloadData()
		tableView.layoutIfNeeded()

		tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: true)
	}
	
	// MARK: ExpandingCellDelegate
	
	// update the table view cell height
	func updateCellHeight(_ indexPath: IndexPath, comment: String) {
		UIView.setAnimationsEnabled(false)
		self.tableView.beginUpdates()
		self.tableView.setNeedsDisplay()
		self.tableView.endUpdates()
		self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
		UIView.setAnimationsEnabled(true)
	}
	
	// update the data source on key press
	func updateArray(_ indexPath: IndexPath, text: String) {
		let row = indexPath.row-1
		let section = indexPath.section
		
		if (section == 0) {
			print("Appedning [", text , "] to ingredients[",row,"]")
			self.ingredients[row] = text
		} else {
			self.steps[row] = text
		}
	}
	
} //EOC

