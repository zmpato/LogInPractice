//
//  ViewController.swift
//  LogInPractice
//
//  Created by Zach mills on 1/8/20.
//  Copyright © 2020 Zach mills. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var logInButton: UIButton!
    
    
    @IBAction func logIn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newValue.setValue(textField.text, forKey: "name")
        
        do {
            try context.save()

            textField.alpha = 0
            logInButton.alpha = 0
            label.alpha = 1
            label.text = "Hey " + textField.text! + "!"
            
            
            
        }
        
        catch{
            print("Failed to save")
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                if let username = result.value(forKey: "name") as? String {
                    
                    textField.alpha = 0
                    logInButton.alpha = 0
                    label.alpha = 1
                    label.text = "Hey " + username + "! Welcome back!"
                    
                }
            }
            
        }
        catch{
            print("Request failed")
        }
        
        
        
        
    }


}

