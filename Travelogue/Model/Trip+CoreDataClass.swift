//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Robert on 5/2/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Trip)
public class Trip: NSManagedObject {
    var entryCount: [Entry]?{
        return Array(self.entries)
    }
    
    convenience init?(title: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        self.init(entity: Trip.entity(), insertInto: context)
        
        self.title = title
    }

}
