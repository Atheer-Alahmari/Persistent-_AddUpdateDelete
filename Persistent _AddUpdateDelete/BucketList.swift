//
//  ViewController.swift
//  Persistent _AddUpdateDelete
//
//  Created by Atheer Alahmari on 12/05/1443 AH.
//

import UIKit
import CoreData

class BucketList: UITableViewController , Button_Delegate {

    
    var items : [ItemList] = [] // CoreData
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // CoreData


  
  //--------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchAllItems() // CoreData
    }
    
    
    // ---------CoreData
    func fetchAllItems(){
        let request = NSFetchRequest<ItemList>(entityName: "ItemList")
        do {
            let results = try managedObjectContext.fetch(request)
          items = results
        } catch {
            print(error.localizedDescription) // print("\(error)")
        }
    }


    // MARK: -  ---------------------- save_Pressed -- cansel_Pressed ---------------------------
    
   
    func save_Pressed(pressed: AddItem, text: String, index: NSIndexPath?) {  //------- CoreData
        if text != ""{
       if  let ip = index {
           let item = items[ip.row]
           item.item = text

        } else{
            
            let item = NSEntityDescription.insertNewObject(forEntityName: "ItemList", into: managedObjectContext) as! ItemList

            item.item = text
            items.append(item)

        }
            // This code is identical to the saveContext method in our AppDelegate
            // Try and reference that method to make your code cleaner!
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                    print("Success")
                } catch {
                    print(error.localizedDescription)
                }
            }

            
        tableView.reloadData()
            dismiss(animated: true, completion: nil)

        }
    }
    
    func cansel_Pressed(pressed: AddItem) {
        dismiss(animated: true, completion: nil)
    }
 
    // MARK: - --------------------------------prepare-------------------------------------

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender is UIBarButtonItem {
            
        let navegtion  = segue.destination as! UINavigationController
        let add_Item = navegtion.topViewController as! AddItem
            add_Item.delegate = self
            
           
        }
        else if sender is IndexPath{
            
            
            let navegtion  = segue.destination as! UINavigationController
            let add_Item = navegtion.topViewController as! AddItem
                add_Item.delegate = self
            
            let index = sender as! NSIndexPath
            let editItem = items[index.row]
            add_Item.item = editItem.item!
            add_Item.index_path = index
        }
        
    }
    
    // MARK: -  ------------------------------TableView-------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID_Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].item! // CoreData
        return cell
    }

    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItem_Segue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //...... CoreData ......
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        
        do {
            try managedObjectContext.save()
        }catch{
            print(error.localizedDescription)
            print("\(error)")

        }
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    

}

