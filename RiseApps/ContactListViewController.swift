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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contacts.count == 0 {
            contactListTableView.isHidden = true
            return 0
        } else {
            contactListTableView.isHidden = false
            return contacts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactTableViewCell
        cell.indexLabel.text = "\(indexPath.row + 1)"
        cell.markImageView.image = UIImage(named: contacts[indexPath.row].mark)
        cell.nameLabel.text = "\(contacts[indexPath.row].surname) \(contacts[indexPath.row].name) \(contacts[indexPath.row].patronymic)"
        return cell
    }
}

