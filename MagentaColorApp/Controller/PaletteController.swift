//
//  ViewController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class PaletteController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let paletteView = PaletteView()
    let paletteTableView = UITableView()
    var colorPalette = [Color]()
    let cellIdentifier = "ColorCell"
    let bottomHeight = CGFloat(80) //Height of bottom controller bar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = paletteView
        
        newPalette()
        setupTableView()
    }

// MARK: - Helper Functions
    fileprivate func setupTableView() {
        paletteTableView.dataSource = self
        paletteTableView.delegate = self
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
        print("--------------tapped-------------")
    }
    
    // MARK: - API Call
    func newPalette() {
        guard let url = URL(string: "https://www.colourlovers.com/api/palettes/top?format=json&numResults=100") else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        
        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Palette.self, from: data)
            self.colorPalette = jsonData.shuffled()
            paletteTableView.reloadData()
        } catch let jsonError {
            print("JSON Error: ", jsonError)
        }
    }
    
// MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.selectionStyle = .none

        //Assigns a new color to each row. Colors are converted from HEX to RGB
        for i in 0..<colorPalette.count {
            for j in 0..<colorPalette[i].colors.count {
                if indexPath.row == j {
                    cell.backgroundColor? = UIColor(hexString: colorPalette[i].colors[j])
                    cell.textLabel?.text = colorPalette[i].colors[j]
                    print("Palette color: " + colorPalette[i].colors[j])
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped on me! \(colorPalette[indexPath.row].colors[indexPath.row])")
    }
}

