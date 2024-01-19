//
//  ViewController.swift
//  ContactList
//
//  Created by Pablo Alarcon on 1/17/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactsTable: UITableView!
    
    var contacts = Contacts.shared.list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        
        contactsTable.dataSource = self
        contactsTable.delegate = self
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        contactsTable.register(nib, forCellReuseIdentifier: "ContactCell")
        // Do any additional setup after loading the view.
    }


    @IBAction func addTapped(_ sender: UIBarButtonItem) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(identifier: "Details") as? DetailsViewController else { return }
        
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension ViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Contacts.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! TableViewCell
        
        cell.delegate = self
        cell.setContact(Contacts.shared.list[indexPath.row])
        
        return cell
    }
    
    
}

extension ViewController: CellDelegate {
    
    func editTapped(cell: TableViewCell) {
        guard let index = contactsTable.indexPath(for: cell)?.row else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(identifier: "Details") as? DetailsViewController else { return }
        
        vc.contactIndex = index
        vc.contact = Contacts.shared.list[index]
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func deleteTapped(cell: TableViewCell) {
        guard let index = contactsTable.indexPath(for: cell)?.row else { return }
        
        let alert = UIAlertController(title: "Confirm Delete", message: "Are you sure?", preferredStyle: .alert)
        
        let confirmDelete = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            Contacts.shared.list.remove(at: index)
            self?.contactsTable.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        
        alert.addAction(confirmDelete)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}

extension ViewController: DetailsDelegate {
    
    func contactSaved(_ contact: Contact) {
        contactsTable.reloadData()
    }
    
}
