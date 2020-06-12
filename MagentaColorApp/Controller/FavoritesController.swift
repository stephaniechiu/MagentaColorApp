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

    let paletteController = PaletteController()
    let favoritesTableView = UITableView()
    let reuseIdentifier = "favoritesCell"
    let hapticFeedback = UIImpactFeedbackGenerator()
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    var retrieveFavoritePalette: [CKRecord] = []
    
// MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        queryDatabase()
    }
    
// MARK: - Helper Functions
    
    func setupTableView() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
//        favoritesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let heightOfCells: CGFloat = 100
        favoritesTableView.rowHeight = heightOfCells
        
        
        view.addSubview(favoritesTableView)
        favoritesTableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func queryDatabase() {
        let query = CKQuery(recordType: "Favorite", predicate: NSPredicate(value: true))
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if error == nil {
                print("Record retrieved")
                
                for record in records! {
                    self.retrieveFavoritePalette.append(record)
                }
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
    
    func deleteRecordWithID(recordID: CKRecord, completion: ((_ recordID: CKRecord?, _ error: Error?) -> Void)?) {
        privateDatabase.delete(withRecordID: recordID.recordID) { (recordIDs, error) in
            completion?(recordID, error)
        }
    }

// MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrieveFavoritePalette.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let paletteRecord: CKRecord = retrieveFavoritePalette[indexPath.row]
        let line = retrieveFavoritePalette[indexPath.row].value(forKey: "FavoritePalette") as? [String] ?? []
        var individualColorView: [UIView] = []
//        print(paletteRecord.value(forKey: "FavoritePalette"))
        
        for i in 0..<5 {
            let xAxis = i * 20
            let individualView = UIView(frame: CGRect(x: xAxis, y: 0, width: 20, height: 80))
            individualColorView.append(individualView)
        }
        
        for j in 0..<line.count {
            let allColorsView = individualColorView[j]
            allColorsView.backgroundColor = UIColor(hexString: line[j])
            cell.addSubview(allColorsView)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let paletteRecord: CKRecord = retrieveFavoritePalette[indexPath.row]
            deleteRecordWithID(recordID: paletteRecord, completion: { (paletteRecord, error) in
                self.retrieveFavoritePalette.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.favoritesTableView.deleteRows(at: [indexPath], with: .right)
                }
            })
        }
    }
    
    // MARK: - TableView Delegate
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hapticFeedback.impactOccurred()
        print("hello")
    }
}
