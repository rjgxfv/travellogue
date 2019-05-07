//
//  TripCreatorViewController.swift
//  Travelogue
//
//  Created by Robert on 5/2/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit

class TripCreatorViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save(_ sender: Any) {
        let trip = Trip(title: titleField.text!)
        let managedContext = trip?.managedObjectContext
        do{
            try managedContext?.save()
        }
        catch{
            print("Failed to save file.")
        }
        self.navigationController?.popViewController(animated: true)
    }
}
