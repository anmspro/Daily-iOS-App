 //
//  ToDoListViewController.swift
//  todo
//
//  Created by CSE on 4/12/19.
//  Copyright © 2019 CSE. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Foundation

var todaydate = Date()
var tcalendar = Calendar.current

let tday = tcalendar.component(.day, from: todaydate)
let tweekday = tcalendar.component(.weekday, from: todaydate)
var tmonth = tcalendar.component(.month, from: todaydate)
var tyear = tcalendar.component(.year, from: todaydate)

 struct Todo{
     var isChecked: Bool
     var todoName: String
 }
 
class ToDoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var progressPercentage: UILabel!
    @IBOutlet weak var TodoTableView: UITableView!
    
    var userID = Auth.auth().currentUser?.uid
    var todos: [Todo] = []
    
    var countComplete:Int = 0
    var countTodos:Int = 0
    var progP:Int = 0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            countTodos = todos.count
            return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tcell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        
        tcell.todoLabel.text = todos[indexPath.row].todoName
        
        if todos[indexPath.row].isChecked{
            tcell.checkMarkImage.image = UIImage(named: "checkmark.png")
        }
        else{
            tcell.checkMarkImage.image = nil
        }
        
        progP = 0
        
        if countTodos != 0{
            progP = countComplete * 100 / countTodos
        }
        
        progressPercentage.text = "\(progP)" + "%"
        return tcell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ref = Database.database().reference(withPath: "users").child(userID!).child("todos").child(todos[indexPath.row].todoName)
        
        //let ref2 = Database.database().reference(withPath: "users").child(userID!)
        
        //ref2.setValue(["CompleteTask": 0])

        if todos[indexPath.row].isChecked{
            todos[indexPath.row].isChecked = false
            countComplete -= 1
            ref.updateChildValues(["isChecked": false])
        }
        else{
            todos[indexPath.row].isChecked = true
            countComplete += 1
            ref.updateChildValues(["isChecked": true])
        }
        
        TodoTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let ref = Database.database().reference(withPath: "users").child(userID!).child("todos").child(todos[indexPath.row].todoName)
            
            ref.removeValue()
            todos.remove(at: indexPath.row)
            TodoTableView.reloadData()
        }
    }
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TodoTableView.delegate = self
        TodoTableView.dataSource = self
        TodoTableView.rowHeight = 80
        
        date.text = " \(tday) - \(tmonth) - \(tyear)"
        
        loadTodos()
    
    }
    
    @IBAction func addTodo(_ sender: Any) {
        let todoAlert = UIAlertController(title: "New Activity", message: "Add your activity", preferredStyle: .alert)
               
       todoAlert.addTextField()
       
       let addTodoAction = UIAlertAction(title: "Add", style: .default){ (action) in
           let todoText = todoAlert.textFields![0].text
           self.todos.append(Todo(isChecked: false, todoName: todoText!))
           let ref = Database.database().reference(withPath: "users").child(self.userID!).child("todos")
           ref.child(todoText!).setValue(["isChecked": false])
           self.TodoTableView.reloadData()
       }
       
       let cancelAction = UIAlertAction(title: "Cancel", style: .default)
       
       todoAlert.addAction(addTodoAction)
       todoAlert.addAction(cancelAction)
       
       present(todoAlert, animated: true, completion: nil)
    }
    
    func loadTodos(){
        let ref = Database.database().reference(withPath: "users").child(userID!).child("todos")
        
        countComplete = 0
        
        ref.observeSingleEvent(of: .value){ (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]{
                let todoName = child.key
                let todoRef = ref.child(todoName)
                
                todoRef.observeSingleEvent(of: .value, with: { (todoSnapshot) in
                    let value = todoSnapshot.value as? NSDictionary
                    let isChecked = value!["isChecked"] as? Bool
                    if isChecked == true{
                        self.countComplete += 1
                    }
                    self.todos.append(Todo(isChecked: isChecked!, todoName: todoName))
                    self.TodoTableView.reloadData()
                })
            }
        }
            
    }
    
}


