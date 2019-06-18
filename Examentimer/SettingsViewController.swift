//
//  SettingsViewController.swift
//  Examentimer
//
//  Created by Benjamin Schnabel on 11.06.19.
//  Copyright © 2019 Acheros. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let defaults = UserDefaults.standard
    var savedDueDate:Date? = Date()
    
    @IBAction func SaveAction(_ sender: UIButton) {
        //save configuration
        
        saveSettings()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func CancelButton(_ sender: UIButton) {
        //cancel
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var DaysLabel: UILabel!
    
    @IBOutlet weak var DatePicker: UIDatePicker!

    @IBAction func DatePickerChanged(_ sender: UIDatePicker) {
        updateDays()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load configuration

        // Do any additional setup after loading the view.
       DatePicker.datePickerMode = .date
        loadSettings()
        if(savedDueDate != nil) {
            DatePicker.setDate(savedDueDate!, animated: true)
            updateDays()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showDatePicker(){
        //show days left to deadline
        
    }
    
    func updateDays(){
        let formatter = DateFormatter()
        formatter.dateFormat = "DD"
        let calendar = Calendar.current

        let dueDate = calendar.startOfDay(for: DatePicker.date)
        let today = calendar.startOfDay(for: Date())
        
        let daysleft = calendar.dateComponents([.day], from: today, to: dueDate).day!
        
        print(daysleft)
        self.DaysLabel.text = "\(daysleft) Tage übrig"
        if(daysleft <= 3) {
            self.DaysLabel.textColor = UIColor.red
        } else {
            self.DaysLabel.textColor = UIColor.black
        }
    }

    func saveSettings(){
        defaults.set(DatePicker.date, forKey: "DueDate")
    }
    
    func loadSettings(){
        savedDueDate = defaults.object(forKey: "DueDate") as? Date
    }
}
