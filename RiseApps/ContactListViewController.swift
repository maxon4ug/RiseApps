//
//  ViewController.swift
//  RiseApps
//
//  Created by Max Surgai on 27.07.17.
//  Copyright © 2017 Max Surgai. All rights reserved.
//

import UIKit
import RealmSwift

class ContactListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contactListTableView: UITableView!
    let realm = try! Realm()
    lazy var contacts: Results<Contact> = { self.realm.objects(Contact.self) }()
    var sortedContacts = Array<Contact>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactListTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    func updateData() {
        contacts = realm.objects(Contact.self)
        sortedContacts = contacts.sorted { $0.surname < $1.surname }
        contactListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortedContacts.count == 0 {
            contactListTableView.isHidden = true
            return 0
        } else {
            contactListTableView.isHidden = false
            return sortedContacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactTableViewCell
        cell.indexLabel.text = "\(indexPath.row + 1)"
        cell.markImageView.image = UIImage(named: sortedContacts[indexPath.row].mark)
        cell.nameLabel.text = "\(sortedContacts[indexPath.row].surname) \(sortedContacts[indexPath.row].name) \(sortedContacts[indexPath.row].patronymic)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            try! self.realm.write {
                self.realm.delete(self.sortedContacts[indexPath.row])
            }
            self.updateData()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editContactSegue" else { return }
        let destinationVC = (segue.destination as! UINavigationController).viewControllers.first as! EditContactTableViewController
        if let selectedCell = (sender as? UITableViewCell), let row = contactListTableView.indexPath(for: selectedCell)?.row {
            destinationVC.selectedContact = sortedContacts[row]
        }
    }
}

