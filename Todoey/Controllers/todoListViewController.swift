//
//  ViewController.swift
//  Todoey
//
//  Created by Kaleb Kougl on 6/19/18.
//  Copyright © 2018 Kaleb Kougl. All rights reserved.
//

import UIKit
import CoreData

class todoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard

    var itemArray : [Item] = []
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //UiAppplication, singleton access through shared, accessing delegate, casting
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadItems()
        
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
        
        self.saveItems()
        
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
                
                
                let newItem = Item(context: self.context)
                
                newItem.title = textField.text!
                newItem.done = false
                
                self.itemArray.append(newItem)
                
                self.saveItems()
                
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
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
        
    }
    
//    func loadItems() {
//        let decoder = PropertyListDecoder()
//        if let data = try? Data(contentsOf: dataFilePath!) { //try? because throws errror
//            //optional binding to unwrap safetly
//            let decoder = PropertyListDecoder()
//            do {
//            itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print ("Error decoding item array, \(error)")
//            }
//        }
//
//    }
}

