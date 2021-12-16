//
//  Button_Delegate.swift
//  Persistent _AddUpdateDelete
//
//  Created by Atheer Alahmari on 12/05/1443 AH.
//

import UIKit
protocol Button_Delegate :class{
    func cansel_Pressed( pressed : AddItem)
    func save_Pressed( pressed : AddItem,  text : String ,  index : NSIndexPath?)

}

