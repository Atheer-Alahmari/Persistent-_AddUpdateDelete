//
//  ItemList+CoreDataProperties.swift
//  Persistent _AddUpdateDelete
//
//  Created by Atheer Alahmari on 12/05/1443 AH.
//
//

import Foundation
import CoreData


extension ItemList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemList> {
        return NSFetchRequest<ItemList>(entityName: "ItemList")
    }

    @NSManaged public var item: String?

}

extension ItemList : Identifiable {

}
