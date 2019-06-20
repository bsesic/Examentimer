//
//  ViewController.swift
//  Examentimer
//
//  Created by Benjamin Schnabel on 11.06.19.
//  Copyright © 2019 Acheros. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ShouldDaysDelegate {
    
    let defaults = UserDefaults.standard
    var savedDueDate:Date? = Date()
    //let shouldDays = ItemsTableViewController()
    var examenItemsDictionary: Dictionary = [String: String]()

    @IBOutlet weak var DaysLeft: UILabel!

    
    @IBOutlet weak var ShouldDays: UILabel!
    //lazy var shouldDaysLabel = ShouldDays
    
    var itemsTableViewController: ShouldDaysDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _ = loadDueDateFromSettings()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        _ = loadDueDateFromSettings()
        //setShouldDays(days: shouldDays.updateStatistics())
        //var shouldDaysLabel = ShouldDays
        //var sum = calculateStatistics()
        //shouldDaysLabel?.text = String(format: "%.2f", sum)  + " / Tag"
    }
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //

        if segue.identifier == "EmbedSegue" {
            itemsTableViewController = segue.destination as? ShouldDaysDelegate
            itemsTableViewController?.setShouldDays(days: <#T##Float#>)
        }
        
    } */

    /*
    //update labels
    func updateLabels(daysleft: String, isDays: String, shouldDays: String) {
        DaysLeft?.text = daysleft
        ShouldDays?.text = shouldDays
    }
 */
    
    //load due date from settings
    func loadDueDateFromSettings() -> Int {
        let formatter = DateFormatter()
        savedDueDate = defaults.object(forKey: "DueDate") as? Date
        if(savedDueDate != nil ) {
        formatter.dateFormat = "DD"
        let calendar = Calendar.current
        
        let today = calendar.startOfDay(for: Date())
        
        let daysleft:Int = calendar.dateComponents([.day], from: today, to: savedDueDate!).day!
        
        DaysLeft?.text = "\(daysleft) Tage übrig"
        return daysleft
        } else { return 0 }
    }
    
    func setShouldDays (days: Float) {
        print (String(format: "%.2f", days)  + " / Tag")
        ShouldDays?.text = String(format: "%.2f", days)  + " / Tag"

    }
    
    func updateStatistics() {
        //viewWillAppear(false)
        //viewWillLayoutSubviews()
        //var shouldDaysLabel = ShouldDays
        //var sum = calculateStatistics()
        //ShouldDays?.text = String(format: "%.2f", sum)  + " / Tag"

    }
    /*
    func calculateStatistics() -> Float {
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
        
        savedDueDate = defaults.object(forKey: "DueDate") as? Date
        if defaults.dictionary(forKey: "ExamenDictionary") != nil {
            examenItemsDictionary = defaults.dictionary(forKey: "ExamenDictionary") as! [String : String]
        }
        
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
               return sum
            } else { return 0 }
        } else { return 0 }
    }
    */
}
