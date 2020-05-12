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
    var colorPalette = [Color]()
    let cellIdentifier = "ColorCell"
    let bottomHeight = CGFloat(60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = paletteView
        
        newPalette()
        setupTableView()
    }

// MARK: - Helper Functions
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
    
    // MARK: - Selectors
    @objc func randomPalette(sender: UIButton) {
        newPalette()
        print("click")
    }
    
    // MARK: - API Call
    func newPalette() {
        guard let url = URL(string: "https://www.colourlovers.com/api/palettes/top?format=json") else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        
        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([Color].self, from: data)
            print(jsonData[3])
            paletteTableView.reloadData()
        } catch let jsonError {
            print("JSON Error: ", jsonError)
        }
    }
    
    func parse(json: Data) {
        
    }
    
// MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorPalette.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//        cell.textLabel?.text = colorPalette[indexPath.row]
        return cell
    }
}

