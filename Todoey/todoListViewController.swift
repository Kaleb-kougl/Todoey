//
//  ViewController.swift
//  Todoey
//
//  Created by Kaleb Kougl on 6/19/18.
//  Copyright © 2018 Kaleb Kougl. All rights reserved.
//

import UIKit

class todoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard

    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //This is going to load data saved to the device or persistent data
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] { // allows first run when this doesn't exist yet
            itemArray = items
        }
        
    }
    
    
    //Mark:- Tableview DataSource methods
    
    //This is where it looks to find things to put in the tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        
        return cell
    }
    
    //Mark:- TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (itemArray[indexPath.row])
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark:- Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//        print("New item button pressed")
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks the add item button on uialert
//            print("Add item action performed")
            
            if (textField.text! != "") {
                self.itemArray.append(textField.text!)
                
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")//This saves data to the app sandbox
                
                self.tableView.reloadData()
            }
//            //print(textField.text!)
            
        }
        
        //adds the textfield to the alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        //adds the action button to the alert
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

