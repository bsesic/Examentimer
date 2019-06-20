//
//  ItemViewController.swift
//  Examentimer
//
//  Created by Benjamin Schnabel on 15.06.19.
//  Copyright © 2019 Acheros. All rights reserved.
//

import UIKit


protocol ItemsDelegate {
    func didSetData(title: String, detail: Int)
}


class ItemViewController: UIViewController {
    
    var delegate: ItemsDelegate!
    
    var itemsTableViewController:ItemsTableViewController?
    
    //var item:String?
    var itemsArray: [String] = []


    @IBOutlet weak var TitleEditText: UITextField!
    
    @IBOutlet weak var DetailEditText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if(!itemsArray.isEmpty){
            TitleEditText?.text = itemsArray[0]
            DetailEditText?.text = itemsArray[1]
        }
    }
    

    @IBAction func cancelButtonpressed(_ sender: UIButton) {
             print("Cancelbutton pressed")
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func addItemButton(_ sender: UIButton) {
        //TOOD: return title and detail to table view, use delegate
        
        //pass content to table view
        print("Addbutton pressed")
        print("Title \(TitleEditText.text!)")
        print("Detail \(DetailEditText.text!)")
        if((!(TitleEditText.text?.isEmpty)!) && (!(DetailEditText.text?.isEmpty)!)) {
            // TODO: send data back to table view by using a delegate
            
            TitleEditText?.isUserInteractionEnabled = false
            delegate.didSetData(title: String(TitleEditText.text!), detail: Int(DetailEditText.text!)!)
            
            
            // leave the screen
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
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
    
}
