//
//  Entry+CoreDataClass.swift
//  Travelogue
//
//  Created by Robert on 5/2/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Entry)
public class Entry: NSManagedObject {
    convenience init?(title: String, body: String, image: NSData, trip: Trip, modDate: Date?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        self.init(entity: Entry.entity(), insertInto: managedContext)
        
        self.body = body
        self.image = image
        self.modDate = modDate! as NSDate
        self.title = title
        self.trip = trip
    }
    
    func update(title: String, body: String, image: NSData, trip: Trip, modDate: Date?){
        self.body = body
        self.image = image
        self.modDate = modDate! as NSDate
        self.title = title
        self.trip = trip
    }
}
