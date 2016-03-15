//
//  ResetPasswordViewController.swift
//  FT
//
//  Created by Mariah Sami Khayat on 3/14/16.
//  Copyright © 2016 Mariah. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    var ref = Firebase (url: "https://mariahfinaltest.firebaseio.com/")
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


    @IBAction func ResetPassword(sender: AnyObject) {
        ref.resetPasswordForUser(EmailTextField.text) { (error) -> Void in
            if error != nil {
                
                if let errorCode = FAuthenticationError(rawValue: error.code) {
                    switch (errorCode) {
                        
                    case .UserDoesNotExist:
                        print("Invalid user")
                        let ExistMessage = "Enter an Exist Email Address"
                        self.disaplayErrorMessage(ExistMessage)
                        
                    case .InvalidEmail:
                        print("Handle invalid email")
                        let VaildMessage = "Enter a Valid Email Address"
                        self.disaplayErrorMessage(VaildMessage)
                        
                    default:
                        print("Handle default situation")
                        
                    }
                }
                
            } else {
                
                print("Password Reset Sent Successfully")
                if let Email = self.EmailTextField.text {
                    let successMessage = "Email Message Sent to You at \(Email)"
                    
                    self.disaplaySuccessMessage(successMessage) }
            }
        } //reset
    } //Button
    
    //Display Alert Message With Confirmation
    func disaplayErrorMessage(theMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message: theMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let OkAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
            action in
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        myAlert.addAction(OkAction);
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    //Display Success Message With Confirmation
    func disaplaySuccessMessage(theMessage:String)
    {
        let myAlert = UIAlertController(title: "Success", message: theMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let OkAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
            action in
            self.dismissViewControllerAnimated(true, completion: nil);
        }
        myAlert.addAction(OkAction);
        self.presentViewController(myAlert, animated: true, completion: nil)
    }

    
    }


