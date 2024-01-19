//
//  DetailsViewController.swift
//  ContactList
//
//  Created by Pablo Alarcon on 1/17/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var contactIndex: Int?
    var contact: Contact?
    weak var delegate: DetailsDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Details"
        emailTextField.delegate = self
        
        nameTextField.text = contact?.name
        lastNameTextField.text = contact?.lastName
        emailTextField.text = contact?.email
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let newContact = Contact(name: nameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!)
        
        if contact == nil {
            Contacts.shared.add(contact: newContact)
        } else {
            Contacts.shared.replace(index: contactIndex!, newContact: newContact)
        }
        
        delegate?.contactSaved(newContact)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: email)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let email = textField.text, !isValidEmail(email) {
            emailTextField.textColor = .red
            saveButton.isEnabled = false
        } else {
            emailTextField.textColor = .black
            saveButton.isEnabled = true
        }
    }
    
    
}


protocol DetailsDelegate: AnyObject {
    func contactSaved(_ contact: Contact)
}
