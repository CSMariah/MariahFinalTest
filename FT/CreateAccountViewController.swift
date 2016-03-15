//
//  CreateAccountViewController.swift
//  FT
//
//  Created by Mariah Sami Khayat on 3/14/16.
//  Copyright © 2016 Mariah. All rights reserved.
//

import UIKit


class CreateAccountViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var ref = Firebase (url: "https://mariahfinaltest.firebaseio.com")
    
   
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RePasswordTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var CityPicker: UIPickerView!
    @IBOutlet weak var DetailsTextView: UITextView!
    
    
    //PickerBar
    var CityPickerVar = ""
    var CityPickerArray = ["Makkah", "Jeddah", "Madinah", "Riyadh", "Jubail","Tabook", "Abha"]
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CityPickerArray[row]
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityPickerArray.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CityPickerVar = CityPickerArray[row]
    }
    
    
    
    

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Picker
        CityPicker.delegate=self
        CityPicker.dataSource=self
        CityPickerVar=CityPickerArray[0]

     
    }


    @IBAction func Done(sender: AnyObject) {
        
        if EmailTextField.text == "" || PasswordTextField.text == "" || NameTextField.text == "" || RePasswordTextField.text == "" {
                      print("Make sure to enter in each textfield")
        }
        
        else {
            
            if PasswordTextField.text != RePasswordTextField.text {
            print("You Entered Different Password")
            }
            
            else {
                
          ref.createUser(EmailTextField.text, password: PasswordTextField.text, withCompletionBlock: { (ErrorType) -> Void in
            if ErrorType != nil {
            let MyError = ErrorType
                print(MyError) }
            else {
            print("Success Sign Up")
                
                self.ref.authUser(self.EmailTextField.text, password: self.PasswordTextField.text, withCompletionBlock: { (ErrorType, authData) -> Void in
                    
                    if ErrorType != nil {
                        print(ErrorType)
                        print("There is an error with given information")}
                    
                    else {
                    
                         var userId = authData.uid
             
                        let newUser = [
                            
                            "provider": self.PasswordTextField.text!,
                            "email": self.EmailTextField.text!,
                            "name": self.NameTextField.text! ,
                            "details": self.DetailsTextView.text!,
                            "Picker": self.CityPickerVar
                        ]
                        NSUserDefaults.standardUserDefaults().setValue(self.EmailTextField.text, forKey: "email")
                        NSUserDefaults.standardUserDefaults().setValue(self.PasswordTextField.text, forKey: "password")
                        
                        self.ref.childByAppendingPath("users").childByAppendingPath(authData.uid).setValue(newUser)
                    self.performSegueWithIdentifier("SignUpComplete", sender: self)
                    
                    
                    }
                })
                
                
            }
            
          })
            
            
            } //less else
            
            
        
        }
    } //Big Else


} //UI
