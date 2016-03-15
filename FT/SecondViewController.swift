//
//  SecondViewController.swift
//  FT
//
//  Created by Mariah Sami Khayat on 3/13/16.
//  Copyright © 2016 Mariah. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var ref = Firebase (url: "https://mariahfinaltest.firebaseio.com")
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
   /*
    override func viewDidAppear(animated: Bool) {
        if ref.authData != nil {
            print("there is a user already signed in")
            self.performSegueWithIdentifier("", sender: self)
        } else {
            print("You will have to login or sign up")
        }
    }
*/
    

    
    
    @IBAction func SignIn(sender: AnyObject) {
        
        if EmailTextField.text == "" || PasswordTextField.text == "" {
        print("Make sure to enter in each textfield")
        } else {
            
            
        ref.authUser(EmailTextField.text, password: PasswordTextField.text, withCompletionBlock: { (ErrorType, authData) -> Void in
            
            if ErrorType != nil {
            print(ErrorType)
            print("There is an error with given information")
            }
            else {
                NSUserDefaults.standardUserDefaults().setValue(self.EmailTextField.text, forKey: "email")
                NSUserDefaults.standardUserDefaults().setValue(self.PasswordTextField.text, forKey: "password")
                
                self.performSegueWithIdentifier("loggedIn", sender: self)
            print("Success Sign In")
               
            }
            
            
        })
        
        
        }

    
    } //button
    
    
    


} //UI

