//
//  Contacts.swift
//  ContactList
//
//  Created by Pablo Alarcon on 1/17/24.
//

import Foundation

class Contacts {
    
    static let shared = Contacts()
    
    var list: [Contact] = []
    
    private init() {
        add(contact: Contact(name: "Jhon", lastName: "Doe", email: "jhon@email.com"))
        add(contact: Contact(name: "Alice", lastName: "Alison", email: "alice@email.com"))
        add(contact: Contact(name: "Bob", lastName: "Bobson", email: "bob@email.com"))
    }
    
    func add(contact: Contact) {
        list.append(contact)
    }
    
    func remove(index: Int) {
        list.remove(at: index)
    }
    
    func replace(index: Int, newContact: Contact) {
        list[index] = newContact
    }
}


