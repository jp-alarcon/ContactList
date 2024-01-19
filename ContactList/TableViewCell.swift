//
//  TableViewCell.swift
//  ContactList
//
//  Created by Pablo Alarcon on 1/17/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    weak var delegate: CellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContact(_ contact: Contact) {
        nameLabel.text = contact.name
        lastNameLabel.text = contact.lastName
        emailLabel.text = contact.email
    }
    
    
    @IBAction func editTapped(_ sender: UIButton) {
        delegate?.editTapped(cell: self)
    }
    
    @IBAction func deleteTapped(_ sender: UIButton) {
        delegate?.deleteTapped(cell: self)
    }
    
    
}


protocol CellDelegate: AnyObject {
    
    func editTapped(cell: TableViewCell)
    
    func deleteTapped(cell: TableViewCell)
    
}
