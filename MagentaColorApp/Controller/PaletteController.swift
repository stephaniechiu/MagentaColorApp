//
//  ViewController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class PaletteController: UIViewController, UITableViewDataSource {
    
    let paletteView = PaletteView()
    let paletteTableView = UITableView()
    let palette = ColorAPI.getColor()
    let cellIdentifier = "ColorCell"
    let bottomHeight = CGFloat(60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = paletteView
        
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        paletteTableView.dataSource = self
        paletteTableView.isScrollEnabled = false
        
        let heightOfCells: CGFloat = (UIScreen.main.bounds.height - bottomHeight) / 5
        paletteTableView.rowHeight = heightOfCells
        
        paletteTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        view.addSubview(paletteTableView)
        paletteTableView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        
        view.addSubview(paletteView.bottomControllerView)
        paletteView.bottomControllerView.anchor(top: paletteTableView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, height: bottomHeight)
    }
    
// MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return palette.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = palette[indexPath.row].hex
        
        if indexPath.row == 0 {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .orange
        }
        
        return cell
    }
}

