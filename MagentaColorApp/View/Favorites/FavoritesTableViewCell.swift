//
//  FavoritesTableViewCell.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/10/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import CloudKit

class FavoritesTableViewCell: UITableViewCell {

// MARK: - Properties
    let privateDatabase = CKContainer.default().privateCloudDatabase
    var retrieveFavoritePalette = [CKRecord]()
    
    let deleteButton = UIView().imageButton(image: #imageLiteral(resourceName: "trash lightMode"), darkModeImage: #imageLiteral(resourceName: "trash darkMode"), width: 20, height: 20)
    let paletteView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 300, height: 80)
        view.layer.cornerRadius = 15
        
        return view
    }()
    
// MARK: - Init
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellLayout()
        deleteRecord()
     }

     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
// MARK: - Helper Functions
    
    fileprivate func setupCellLayout() {
    }
    
    func retrieve() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Favorite", predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if error == nil {
                print("Record retrieved")
            } else {
                print("Record not retrieved: \(String(describing: error))")
            }
        }
    }
    
    func deleteRecord() {
        deleteButton.addTarget(self, action: #selector(delete(sender:)), for: .touchUpInside)
    }
    
// MARK: - Selector
    
    @objc func delete(sender: UIButton) {
        let recordID = recordIDs.first!
        privateDatabase.delete(withRecordID: recordID) { (deleteRecordID, error) in
            if error == nil {
                print("Record deleted")
            } else {
                print("Record unable to delete: \(String(describing: error))")
            }
        }
    }
    
}
