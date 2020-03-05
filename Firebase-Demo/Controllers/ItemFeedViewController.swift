//
//  ItemFeedViewController.swift
//  Firebase-Demo
//
//  Created by Tanya Burke on 3/3/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import FirebaseFirestore
class ItemFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var listener: ListenerRegistration?
    private var items = [Item](){
        
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        //register a nib file
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        listener = Firestore.firestore().collection(DatabaseService.itemsCollection).addSnapshotListener({ (snapshot, error) in
            if let error = error{
                DispatchQueue.main.async {
                    self.showAlert(title: "Try again latter", message: "\(error.localizedDescription)")
                }
            } else if let snapshot = snapshot{
                let items = snapshot.documents.map{Item($0.data())}
                
                self.items = items
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
    }

 

}

extension ItemFeedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard   let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? ItemCell else{ fatalError("could not down cast as ItemCell")}
        let item = items[indexPath.row]
        cell.configureCell(for: item)
        return cell
    }

}

extension ItemFeedViewController: UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
