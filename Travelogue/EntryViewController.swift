//
//  EntryViewController.swift
//  Travelogue
//
//  Created by Robert on 5/2/19.
//  Copyright © 2019 Robert. All rights reserved.
//

import UIKit
import CoreData
let formatter = DateFormatter()

class EntryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var trip: Trip?
    var entries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.entryCount?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        let entry = trip?.entryCount?[indexPath.row]
        if let cell = cell as? EntryTableViewCell {
            entries.append(entry!)
            let dataImage = Data(referencing: (entry?.image)!)
            let trueImage = UIImage(data:dataImage,scale:1.0)
            cell.cellImage.image = trueImage
            cell.titleLabel.text = entry?.title
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            cell.dateLabel.text = formatter.string(from: entry?.modDate! as! Date)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteEntry(at: indexPath)
        }
    }
    func deleteEntry(at indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        guard let managedContext = entry.managedObjectContext else{
            return
        }
        managedContext.delete(entry)
        do{
            try entry.managedObjectContext?.save()
            entries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch{
            print("saved wrong")
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? EditorViewController{
            destination.trip = trip
            if let row = tableView.indexPathForSelectedRow?.row{
                destination.sentEntry = entries[row]
            }
        }
    }
}
