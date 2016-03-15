//
//  YourAccountViewController.swift
//  FT
//
//  Created by Mariah Sami Khayat on 3/14/16.
//  Copyright © 2016 Mariah. All rights reserved.
//

import UIKit

class YourAccountViewController: UIViewController {

    var ref = Firebase (url: "https://mariahfinaltest.firebaseio.com/")
    
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var DetailsTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let ref = Firebase(url:"https://mariahfinaltest.firebaseio.com/users/\(self.ref.authData.uid)")
        ref.observeEventType(.Value, withBlock: { snapshot in
            let E = snapshot.value.objectForKey("email") as? String
            self.EmailLabel.text = E
            print(self.EmailLabel.text)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            let P = snapshot.value.objectForKey("provider") as? String
            self.PasswordLabel.text = P
            print(self.PasswordLabel.text)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            let N = snapshot.value.objectForKey("name") as? String
            self.NameLabel.text = N
            print(self.NameLabel.text)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            let C = snapshot.value.objectForKey("Picker") as? String
            self.CityLabel.text = C
            print(self.CityLabel.text)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            let D = snapshot.value.objectForKey("details") as? String
            self.DetailsTextView.text = D
            print(self.DetailsTextView.text)
            }, withCancelBlock: { error in
                print(error.description)
        })





  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    
    @IBAction func LogOut(sender: AnyObject) {
        
        ref.unauth()
        self.navigationController!.popToRootViewControllerAnimated(true)
        
        /*
        ref.unauth()
        self.performSegueWithIdentifier("LogOut", sender: self)
*/
    }
 



}
