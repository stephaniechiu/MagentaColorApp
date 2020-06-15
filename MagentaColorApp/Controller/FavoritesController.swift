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
    
    lazy var popToLeftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(popToLeftBarButtonItemTapped))
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    var retrieveFavoritePalette: [CKRecord] = []
    
// MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        queryDatabase()
        setupNavigationController()
    }
    
// MARK: - Helper Functions
    
    func setupTableView() {
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        favoritesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//        favoritesTableView.sectionHeaderHeight = 50
        
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
    
    func setupNavigationController() {
        navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.setRightBarButton(popToLeftBarButtonItem, animated: true)
    }
    
// MARK: - Selectors
    
    @objc fileprivate func popToLeftBarButtonItemTapped() {
        navigationController?.popViewControllerToLeft()
    }

// MARK: - TableView Data Source
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "PALETTES"
//        } else {
//            return "GRADIENTS"
//        }
//    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .label
        header.backgroundColor = .systemBackground
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .label
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding = 10
        let widthPadding = 10
        
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 8
        maskLayer.backgroundColor = UIColor.systemBackground.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: CGFloat(widthPadding/2), dy: CGFloat(verticalPadding/2))
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrieveFavoritePalette.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
//        if indexPath.section == 0 {
        let paletteRecord: CKRecord = retrieveFavoritePalette[indexPath.row]
        let individualColorInRecord = retrieveFavoritePalette[indexPath.row].value(forKey: "FavoritePalette") as? [String] ?? []
        var individualColorView: [UIView] = []
        
        let individualGradientInRecord = retrieveFavoritePalette[indexPath.row].value(forKey: "FavoriteGradient") as? [String] ?? []
        
        for colorView in 0..<5 {
            let xAxis = (colorView * Int(UIScreen.main.bounds.width / 5))
            let individualView = UIView(frame: CGRect(x: xAxis, y: 0, width: Int(UIScreen.main.bounds.width / 5), height: 100))
            individualColorView.append(individualView)
        }
        
        for j in 0..<individualColorInRecord.count {
            let allColorsView = individualColorView[j]
            allColorsView.backgroundColor = UIColor(hexString: individualColorInRecord[j])
//            print(individualColorInRecord[j])
            cell.addSubview(allColorsView)
        }

        for k in 0..<individualGradientInRecord.count {
            let gradientColorLeft = UIColor(hexString: individualGradientInRecord[0])
            let gradientColorRight = UIColor(hexString: individualGradientInRecord[1])

            let individualView = UIView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height)))
            individualView.setupGradientBackground(colorOne: gradientColorLeft, colorTwo: gradientColorRight)
            cell.addSubview(individualView)
            cell.insertSubview(individualView, at: 0)
        }
  
        cell.selectionStyle = .none
        cell.backgroundColor = .systemBackground
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .normal, title: "Share", handler: { (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            let individualColorInRecord = self.retrieveFavoritePalette[indexPath.row].value(forKey: "FavoritePalette") as? [String] ?? []
            let individualGradientInRecord = self.retrieveFavoritePalette[indexPath.row].value(forKey: "FavoriteGradient") as? [String] ?? []
            var string = ""
            
            print(individualColorInRecord)
            string = "Magenta Color App {\n\(individualGradientInRecord) \(individualColorInRecord)\n}"
            
            let activityViewController = UIActivityViewController(activityItems: [string], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        })
        shareAction.backgroundColor = .systemOrange
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: { (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            let paletteRecord: CKRecord = self.retrieveFavoritePalette[indexPath.row]
            self.deleteRecordWithID(recordID: paletteRecord, completion: { (paletteRecord, error) in
                self.retrieveFavoritePalette.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.favoritesTableView.deleteRows(at: [indexPath], with: .right)
                }
            })
        })
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    }
}
