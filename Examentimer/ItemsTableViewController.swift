//
//  ItemsTableViewController.swift
//  Examentimer
//
//  Created by Benjamin Schnabel on 12.06.19.
//  Copyright © 2019 Acheros. All rights reserved.
//

import UIKit


 protocol ShouldDaysDelegate {
    func setShouldDays(days: Float)
}


class ItemsTableViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    var savedDueDate:Date? = Date()
    
    var cellTitle: String = ""
    var cellDetail: Int = 0
    var examenItemsDictionary: Dictionary = [String: String]()
    
    var delegate: ShouldDaysDelegate!
    var ShouldDaysDelegate: ShouldDaysDelegate?
    
    // TODO: convert ExamenItem to Object (class)
    
    @IBOutlet weak var Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadFromSettings()
        _ = updateStatistics()

    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return examenItemsDictionary.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = Array(examenItemsDictionary.keys)[indexPath.row]
        cell.detailTextLabel?.text = Array(examenItemsDictionary.values)[indexPath.row]
        
        return cell
    }
 
    @IBAction func newItem(_ sender: UIBarButtonItem) {
        //MARK: add new Item
        
        
        // call Items detail view
        performSegue(withIdentifier: "MasterToDetail", sender: self)
        
        // fetch the result
        //examenItems.merge([String(cellTitle): String(cellDetail)], uniquingKeysWith: )
        print("New item to add. Title: \(cellTitle) Detail: \(cellDetail)")
        examenItemsDictionary.merge([String(cellTitle): String(cellDetail)]){ (current, _) in current }
        
        saveToSettings()
        _ = updateStatistics()
        tableView.reloadData()
 
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    
   /*
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // TODO: add checkmark
        print("Accessory button tapped")
        
        // FIXME: checkbutton
        let itemsArray = [Array(examenItemsDictionary.keys)[indexPath.row], Array(examenItemsDictionary.values)[indexPath.row]]
        //performSegue(withIdentifier: "MasterToDetail", sender: itemsArray)
    }
*/
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            examenItemsDictionary[Array(examenItemsDictionary.keys)[indexPath.row]] = nil
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveToSettings()
            _ = updateStatistics()

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }*/
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let _ = Int(string) else {
            return true
        }
        return true
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MasterToDetail" {
            let destinationViewController = segue.destination as! ItemViewController
        
            destinationViewController.itemsArray = sender as? [String] ?? [String]()
            destinationViewController.delegate = self
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let index = Array(examenItems.keys)[indexPath.row]
    
        /*
        let itemsArray = [Array(examenItemsDictionary.keys)[indexPath.row], Array(examenItemsDictionary.values)[indexPath.row]]
        performSegue(withIdentifier: "MasterToDetail", sender: itemsArray)*/
        
        checkItem(indexPath: indexPath)
    }

    
    func checkItem(indexPath:IndexPath ){
        var returnArray = Array(examenItemsDictionary.values)[indexPath.row]
        var value:Int = Int(returnArray)! - 1
        if(value <= 0 ) { value = 0 }
        
        examenItemsDictionary.updateValue(String(value), forKey: Array( examenItemsDictionary.keys)[indexPath.row])
        saveToSettings()
        _ = updateStatistics()
        tableView.reloadData()
    }
    
    
    func updateStatistics() -> Float {
        // TODO: update statistics
        
        //get the days
        let formatter = DateFormatter()
        formatter.dateFormat = "DD"
        let calendar = Calendar.current
        
        let dueDate = calendar.startOfDay(for: savedDueDate!)
        let today = calendar.startOfDay(for: Date())
        
        let daysleft = calendar.dateComponents([.day], from: today, to: dueDate).day!
        
        //calculate statistics
        //add all the item values together
        
        var result:Float = 0
        for values in examenItemsDictionary.values{
            print("Values \(values)")
            result += Float(values)!
        }
        
        if(daysleft > 0) {
            //divide the values by the days
            let sum:Float = result / Float(daysleft)
            print ("Sum: \(sum)")

            // TODO: display new statistics
            if(sum > 0) {
                // FIXME: show days delegate is nil!
                delegate?.setShouldDays(days: sum)
                //XXX Label?.text = String(format: "%.2f", sum) + " / Tag"
                //mainViewController.shouldDaysLabel.text = String(format: "%.2f", sum)  + " / Tag"
                
            } //else { return 0 }
        } //else { return 0 }
        return 0
    }
    
    func loadFromSettings(){
        // load from settings
        savedDueDate = defaults.object(forKey: "DueDate") as? Date
        if defaults.dictionary(forKey: "ExamenDictionary") != nil {
            examenItemsDictionary = defaults.dictionary(forKey: "ExamenDictionary") as! [String : String]
        } else { examenItemsDictionary = ["KG": "3", "ST":"4", "PT":"5"] }
    }
    
    func saveToSettings(){
        // save to settings
        defaults.set(examenItemsDictionary, forKey: "ExamenDictionary")
        
    }
}

extension ItemsTableViewController: ItemsDelegate {
    func didSetData(title: String, detail: Int) {

        print("Did set Data, Title: \(title) Detail: \(detail)")
        
        examenItemsDictionary.updateValue((String(detail)), forKey: String(title))
        
        tableView.reloadData()
        
        saveToSettings()
         _ = updateStatistics()
    }
    
}

