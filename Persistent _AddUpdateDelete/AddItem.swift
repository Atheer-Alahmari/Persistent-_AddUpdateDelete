//
//  AddItem.swift
//  Persistent _AddUpdateDelete
//
//  Created by Atheer Alahmari on 12/05/1443 AH.
//

import UIKit

class AddItem: UITableViewController {

    @IBOutlet weak var text_TF: UITextField!
    
    weak var delegate : Button_Delegate?
    var item : String?
    var index_path: NSIndexPath?
    
    //--------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        if item != nil{
           text_TF.placeholder = "Update Item"
            text_TF.text = item
            
        }
    }

    // MARK: - Table view data source

    @IBAction func save_Action(_ sender: UIBarButtonItem) {
        let newitem = text_TF.text!
        delegate?.save_Pressed(pressed: self, text : newitem, index : index_path)
        
    }
    
    
    @IBAction func cancel_Action(_ sender: UIBarButtonItem) {
        delegate?.cansel_Pressed(pressed: self)

        
    }
}
