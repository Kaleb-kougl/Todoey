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

    var itemArray : [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Kill Demogorgan"
        itemArray.append(newItem3)

        
        
        //This is going to load data saved to the device or persistent data
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] { // allows first run when this doesn't exist yet
            itemArray = items
        }
        
    }
    
//////////////////////////////////////////////////////////////////
    //Mark:- Tableview DataSource methods
    
    //This is where it looks to find things to put in the tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //value = conditional statement ? valueOfTrue : valueOfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
 
///////////////////////////////////////////////////////////////////
    //Mark:- TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

/////////////////////////////////////////////////////////////////////
    //Mark:- Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //what will happen when the user clicks the add item button on uialert
            if (textField.text! != "") {
                let newItem = Item()
                
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
                
                self.defaults.set(self.itemArray, forKey: "ToDoListArray")//This saves data to the app sandbox
                
                self.tableView.reloadData()
            }
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

