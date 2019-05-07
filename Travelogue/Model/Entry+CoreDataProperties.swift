//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Robert on 5/2/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var body: String?
    @NSManaged public var image: NSData?
    @NSManaged public var modDate: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var trip: Trip?

}
