//
//  TripsViewController.swift
//  Travelogue
//
//  Created by Robert on 5/2/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import CoreData

class tripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var trips = [Trip]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        do{
            trips = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
        }
        catch{
            print("Fetch failed.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        do{
            trips = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
        }
        catch{
            print("Fetch failed.")
        }    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        if let cell = cell as? TripsTableViewCell {
            cell.titleLabel.text = trips[indexPath.row].title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteTrip(at: indexPath)
        }
    }
    func deleteTrip(at indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        guard let managedContext = trip.managedObjectContext else{
            return
        }
        managedContext.delete(trip)
        do{
            try trip.managedObjectContext?.save()
            trips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.navigationController?.popViewController(animated: true)
        } catch{
            print("saved wrong")
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? EntryViewController ,
            let row = tableView.indexPathForSelectedRow?.row{
            destination.trip = trips[row]
        }
    }
}
