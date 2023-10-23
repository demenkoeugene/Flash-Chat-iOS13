//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message]  = [
        Message(sender: "demenko", body: "hi"),
        Message(sender: "john", body: "hello"),
        Message(sender: "demenko", body: "what's up")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "FlashChat"
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.cellIdentifier)
        
        loadMessage()
    }
    
    func loadMessage(){
      
        
        db.collection(Constant.FStore.collectionName)
            .order(by: Constant.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
                self.messages = []
                
                if let e = error{
                    print("there was an issue retriving data from firestore \(e)")
                }else{
                    if let snapshoDocuments = querySnapshot?.documents{
                        for doc in snapshoDocuments{
                            let data = doc.data()
                            if let messageSender = data[Constant.FStore.senderField] as? String, let messageBody = data[Constant.FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async{
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(Constant.FStore.collectionName).addDocument(data: [
                Constant.FStore.senderField: messageSender,
                Constant.FStore.bodyField: messageBody,
                Constant.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error{
                    print("there was a issua saving data \(e)")
                }else{
                    print("succesfully saving data")
                }
            }
        }
        
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        print(messages[indexPath.row].body)
        return cell
    }
    
    
}
