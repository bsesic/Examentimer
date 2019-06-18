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

    @IBOutlet weak var DaysLeft: UILabel!

    
    @IBOutlet weak var ShouldDays: UILabel!
    var shouldDaysLabel = UILabel()
    
    var itemsTableViewController: ShouldDaysDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _ = loadDueDateFromSettings()
        var daysLeftLabel = DaysLeft
        shouldDaysLabel = ShouldDays!
        shouldDaysLabel.text = "Test"
        //ShouldDays?.text = "Test2"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        _ = loadDueDateFromSettings()
        //setShouldDays(days: shouldDays.updateStatistics())

    }
/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //

        if segue.identifier == "EmbedSegue" {
            itemsTableViewController = segue.destination as? ShouldDaysDelegate
            itemsTableViewController?.setShouldDays(days: <#T##Float#>)
        }
        
    } */

    
    //update labels
    func updateLabels(daysleft: String, isDays: String, shouldDays: String) {
        DaysLeft?.text = daysleft
        ShouldDays?.text = shouldDays
    }
    
    //load due date from settings
    func loadDueDateFromSettings() -> Int {
        let formatter = DateFormatter()
        savedDueDate = defaults.object(forKey: "DueDate") as? Date
        formatter.dateFormat = "DD"
        let calendar = Calendar.current
        
        let today = calendar.startOfDay(for: Date())
        
        let daysleft = calendar.dateComponents([.day], from: today, to: savedDueDate!).day!
        
        DaysLeft?.text = "\(daysleft) Tage übrig"
        return daysleft
    }
    
    func setShouldDays (days: Float) {
        print (String(format: "%.2f", days)  + " / Tag")
        ShouldDays.text = String(format: "%.2f", days)  + " / Tag"

    }
    
}
