//
//  FavoritesController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/7/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import CloudKit

class FavoritesController: UIViewController, UITableViewDataSource, UITableViewDelegate {

// MARK: - Properties
    
    let favoritesView = FavoritesView()
    let paletteController = PaletteController()
    let favoritesTableView = UITableView()
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    var retrieveFavoritePalette = [CKRecord]()
    
//    let predicate = NSPredicate(value: true)
    
// MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        queryDatabase()
//        let query = CKQuery(recordType: "Favorite", predicate: predicate)
//        query.sortDescriptors = [NSSortDescriptor(key: "modificationDate", ascending: false)]
//
//        let operation = CKQueryOperation(query: query)
        
    }
    
// MARK: - Helper Functions
    
    func setupTableView() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "favoriteCell")
        favoritesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let heightOfCells: CGFloat = 400
        favoritesTableView.rowHeight = heightOfCells
        
        
        view.addSubview(favoritesTableView)
        favoritesTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func queryDatabase() {
        let query = CKQuery(recordType: "Favorite", predicate: NSPredicate(value: true))
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if error == nil {
                print("Record retrieved")
            } else {
                print("Record not retrieved: \(String(describing: error))")
            }
            let sortedRecords = records?.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.retrieveFavoritePalette = sortedRecords ?? []
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
    }
    
// MARK: - Selectors
    
// MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return retrieveFavoritePalette.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
//        cell.selectionStyle = .none
        cell.textLabel?.text = retrieveFavoritePalette[indexPath.row].value(forKey: "FavoritePalette") as! String
        return cell
    }
}
