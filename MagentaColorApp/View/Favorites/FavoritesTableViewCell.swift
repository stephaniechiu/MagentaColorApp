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
    
// MARK: - Init
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellLayout()
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
}
