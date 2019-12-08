//
//  ViewController.swift
//  todo
//
//  Created by CSE on 27/11/19.
//  Copyright © 2019 CSE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    var uid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.text = ""
        passwordTF.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignupAction(_ sender: Any) {
        
       if emailTF != nil && passwordTF != nil {
            Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!){ (result, error) in
                if error != nil {
                    print("THERE WAS AN ERROR IN SIGNUP")
                }
                else {
                    self.uid = (result?.user.uid)!

                    let ref = Database.database().reference(withPath: "users").child(self.uid)
                    ref.setValue(["email" : self.emailTF.text!, "password": self.passwordTF.text!])
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                    
                }
            }
        }
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        if emailTF != nil && passwordTF != nil {
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!){ (result, error) in
                if error != nil {
                    print("THERE WAS AN ERROR IN LOGIN")
                }
                else {
                    self.uid = (result?.user.uid)!
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigation = segue.destination as! UINavigationController
        let todoVC = navigation.topViewController as! TodoView
        todoVC.userID = uid
    }
    
}

