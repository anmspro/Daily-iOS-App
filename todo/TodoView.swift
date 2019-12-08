//
//  TodoView.swift
//  todo
//
//  Created by CSE on 28/11/19.
//  Copyright © 2019 CSE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TodoView: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    var userID: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWelcomeLabel()
        if let uid = userID {
            welcomeLabel.text = uid
        }
        // Do any additional setup after loading the view.
    }
    func setWelcomeLabel(){
        let userRef = Database.database().reference(withPath: "users").child(userID!)

    userRef.observeSingleEvent(of: .value) { (snapshot) in
    let value = snapshot.value as? NSDictionary
    let email = value!["email"] as? String
    self.welcomeLabel.text = "Hello, " + email! + "!"
    }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
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
