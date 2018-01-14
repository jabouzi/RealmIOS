//
//  ViewController.swift
//  realmTest
//
//  Created by Skander Jabouzi on 2017-12-30.
//  Copyright © 2017 Skander Jabouzi. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

// MARK: Model

final class TaskList: Object {
    @objc dynamic var text = ""
    @objc dynamic var id = ""
    let items = [Task]()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Task: Object {
    @objc dynamic var text = ""
    @objc dynamic var completed = false
}

class ViewController: UITableViewController {
    
    var items = [Task]()
    var notificationToken: NotificationToken?
    var realm = try! Realm()
    
    deinit {
        notificationToken?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRealm()
    }
    
    func setupUI() {
        title = "My Tasks"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }
    
    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.text
        cell.textLabel?.alpha = item.completed ? 0.5 : 1
        return cell
    }
    
    @objc func add() {
        let alertController = UIAlertController(title: "New Task", message: "Enter Task Name", preferredStyle: .alert)
        var alertTextField: UITextField!
        alertController.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Task Name"
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertTextField.text , !text.isEmpty else { return }
            let task = Task(value: ["text": text])
            self.items.append(task)
            try! self.realm.write {
                self.realm.add(task)
            }
            self.tableView.reloadData()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    func setupRealm() {
//        DispatchQueue.main.async {
            debugPrint("self.items \(self.items)")
            let list = self.realm.objects(Task.self)
            self.items = Array(list)
            self.tableView.reloadData()
//        }
    }
}

