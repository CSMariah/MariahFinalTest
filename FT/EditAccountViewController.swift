//
//  EditAccountViewController.swift
//  FT
//
//  Created by Mariah Sami Khayat on 3/14/16.
//  Copyright © 2016 Mariah. All rights reserved.
//

import UIKit

class EditAccountViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var ref = Firebase (url: "https://mariahfinaltest.firebaseio.com/")
    
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
        print(CityPickerArray[row])
        return CityPickerArray[row]
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(CityPickerArray.count)
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
       
        
      //  CityPicker.selectRow(row, inComponent: 0, animated: true)
        
        
        let ref = Firebase(url:"https://mariahfinaltest.firebaseio.com/users/\(self.ref.authData.uid)")
        ref.observeEventType(.Value, withBlock: { snapshot in
            let E = snapshot.value.objectForKey("email") as? String
            self.EmailTextField.text = E
            print(self.EmailTextField.text)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            let P = snapshot.value.objectForKey("provider") as? String
            self.PasswordTextField.text = P
            print(self.PasswordTextField.text)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            let N = snapshot.value.objectForKey("name") as? String
            self.NameTextField.text = N
            print(self.NameTextField.text)
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        

        
        ref.observeEventType(.Value, withBlock: { snapshot in
            let D = snapshot.value.objectForKey("Picker") as? String
            
            self.CityPickerVar = D as String!
            
            let indexOfA = self.CityPickerArray.indexOf(self.CityPickerVar)
            
            self.CityPicker.selectRow(indexOfA!, inComponent: 0, animated: true)
            
            print(self.CityPickerVar)
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
    
    @IBAction func Done(sender: AnyObject) {
        
        let ref = Firebase(url:"https://mariahfinaltest.firebaseio.com")
        
        print("pass\(self.EmailTextField.text)")
        
        
        
        let mainpass = NSUserDefaults.standardUserDefaults().objectForKey("password") as? String
        let mainEmail = NSUserDefaults.standardUserDefaults().objectForKey("email") as? String
        
        
        
       let isEqu = (mainEmail == self.EmailTextField.text)
        
        if(isEqu == true)
        {
        
        
        }
        else
        {
            ref.changeEmailForUser(mainEmail, password: mainpass,
                
                toNewEmail: self.EmailTextField.text, withCompletionBlock: { error in
                    
                    if error != nil {
                        
                        
                        
                        print("There was an error processing the request")
                        
                        
                        
                    } else {
                        
                        
                        
                        
                        
                        NSUserDefaults.standardUserDefaults().setValue(self.EmailTextField.text, forKey: "email")
                        
                        print("Email changed successfully")
                        
                        
                        
                    }
                    
            })
    
        }
        
        ref.changePasswordForUser( NSUserDefaults.standardUserDefaults().objectForKey("email") as? String
            ,
            fromOld: NSUserDefaults.standardUserDefaults().objectForKey("password") as? String, toNew: PasswordTextField.text)
            { (ErrorType) -> Void in
                
                if ErrorType != nil {
                    print(ErrorType)
                    print("There was an error processing the request")
                }
                else
                {
                    
                    NSUserDefaults.standardUserDefaults().setValue(self.PasswordTextField.text, forKey: "password")
                    
                   
                }
                
        }
        
        
        
        
        let user = ["provider": self.PasswordTextField.text!,
            
            "email": EmailTextField.text!,
            
            "details":self.DetailsTextView.text!,
            
            "Picker":self.CityPickerVar,
            
            "name":self.NameTextField.text!]
        
        
        
        
        
        ref.childByAppendingPath("users").childByAppendingPath(self.ref.authData.uid).updateChildValues(user)
        
        
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    
    


}
