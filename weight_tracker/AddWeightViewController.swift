//
//  AddWeightViewController.swift
//  weight_tracker
//
//  Created by Yash Patel on 29/10/16.
//  Copyright © 2016 Yash Patel. All rights reserved.
//

import UIKit

class AddWeightViewController: UIViewController {
    
    // Fetching date stamp
    let date = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
    let dateToDisplay = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
    @IBOutlet weak var textEnterWeight: UITextField!
    @IBOutlet weak var segmentDayTime: UISegmentedControl!
    
    @IBOutlet weak var dateStamp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateStamp.text = String(dateToDisplay)!

        // Do any additional setup after loading the view.
    }

    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if textEnterWeight.text != "" && isdouble(Arrayofstrings: textEnterWeight.text!) {
        
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let weight = Weight(context: context)
            
            weight.currentweight = textEnterWeight.text!
            weight.datestamp = String(date)!
            weight.daytime = String(segmentDayTime.titleForSegment(at: segmentDayTime.selectedSegmentIndex)!)!
            
            
            // Save to core data
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            navigationController!.popViewController(animated: true)
            
            
        }
        else {
            
            textEnterWeight.text = ""
            textEnterWeight.placeholder = "Enter Valid Weight"
        
        }
        
    }

    
    func isdouble(Arrayofstrings a:String ...) -> Bool {
        var isdub = true
        for i in a {
            
            let doubcheck:Double? = Double(i)
            if doubcheck == nil{
                isdub = false
            }
            
        }
        return isdub
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
