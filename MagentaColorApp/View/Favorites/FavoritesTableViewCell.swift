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
   
//        let color1 = UIView()
//        color1.backgroundColor = .red
//        let color2 = UIView()
//        color2.backgroundColor = .orange
//        let color3 = UIView()
//        color3.backgroundColor = .yellow
//        let color4 = UIView()
//        color4.backgroundColor = .green
//        let color5 = UIView()
//        color5.backgroundColor = .blue
//
//        let stack = UIStackView(arrangedSubviews: [color1, color2, color3, color4, color5])
//        stack.distribution = .fillEqually
//
//        view.addSubview(stack)
//        stack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        return view
    }()
    
// MARK: - Init
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        var paletteRecord: CKRecord
//        let paletteRecord: CKRecord = retrieveFavoritePalette[indexPath.row]
//        let line = paletteRecord.value(forKey: "FavoritePalette") as? [String] ?? []
//        var individualColorView: [UIView] = []
//        for i in 0..<5 {
//            let xAxis = i * 20
//            let individualView = UIView(frame: CGRect(x: xAxis, y: 0, width: 20, height: 80))
//            individualColorView.append(individualView)
//        }
//        
//         for j in 0..<line.count {
//            let allColorsView = individualColorView[j]
//        //            print(individualColorView[j])
//            allColorsView.backgroundColor = UIColor(hexString: line[j])
//            tableView.addSubview(allColorsView)
//        }
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellLayout()
        deleteRecord()
        
        
     }

     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
// MARK: - Helper Functions
    
    fileprivate func setupCellLayout() {
//        addSubview(paletteView)
//        paletteView.anchor(width: 250, height: 10)
//        paletteView.centerY(inView: self)
//        paletteView.centerX(inView: self)
        
//        addSubview(deleteButton)
//        deleteButton.anchor(right: rightAnchor, paddingRight: 15)
//        deleteButton.centerY(inView: self)
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
