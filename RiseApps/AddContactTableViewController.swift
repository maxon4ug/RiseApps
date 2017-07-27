//
//  AddContactTableViewController.swift
//  RiseApps
//
//  Created by Max Surgai on 27.07.17.
//  Copyright © 2017 Max Surgai. All rights reserved.
//

import UIKit
import RealmSwift

class AddContactTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var patronymicTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    @IBOutlet weak var bisexualButton: UIButton!
    var selectedMark = ""
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    func addTargets() {
//        self.navigationItem.rightBarButtonItem!.isEnabled = false
        nameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        surnameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        patronymicTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        maleButton.addTarget(self, action: #selector(editingChanged), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(editingChanged), for: .touchUpInside)
        genderButton.addTarget(self, action: #selector(editingChanged), for: .touchUpInside)
        bisexualButton.addTarget(self, action: #selector(editingChanged), for: .touchUpInside)
    }

    func editingChanged(_ view: UIView?) {
        if let textField = view as? UITextField {
            if textField.text?.characters.count == 1 && textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        } else if let tappedButton = view as? UIButton {
            let markButtons = [maleButton,femaleButton,genderButton,bisexualButton]
            for button in markButtons {
                if tappedButton == button {
                    button!.isSelected = true
                    selectedMark = button!.currentTitle!
                } else {
                    button!.isSelected = false
                }
            }
        }
        guard nameTextField.text != "" && surnameTextField.text != "" && phoneTextField.text != "" && patronymicTextField.text != "" && selectedMark != "" else {
            self.navigationItem.rightBarButtonItem!.isEnabled = false
            return
        }
        self.navigationItem.rightBarButtonItem!.isEnabled = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        let newContact = Contact()
        newContact.name = nameTextField.text!
        newContact.surname = surnameTextField.text!
        newContact.patronymic = patronymicTextField.text!
        newContact.phone = phoneTextField.text!
        newContact.mark = selectedMark
        try! realm.write {
            realm.add(newContact)
        }
        dismiss(animated: true, completion: nil)
    }
}
