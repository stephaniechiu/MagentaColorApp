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
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = paletteView
        
        newPalette()
        setupTableView()
        colorButtons()
    }

// MARK: - Helper Functions
    
    //Creates buttons the size of each cell, which will expand to fill that cell's color when user taps on the button/cell
    func colorButtons() {
        var tag = 0
        var buttonY: CGFloat = 0
        
        for i in 0..<1 {
            for color in colorPalette[i].colors {
                let button = UIButton(frame: CGRect(x: 15, y: buttonY, width: UIScreen.main.bounds.width - 30, height: (UIScreen.main.bounds.height - 100) / 5))
                    buttonY = buttonY + (UIScreen.main.bounds.height/5 - 15)
                    button.backgroundColor = .darkGray
                    button.setTitle("Oh boy! \(color)", for: .normal)
                    button.titleLabel?.text = "\(color)"
                    button.addTarget(self, action: #selector(openColor(sender:)), for: .touchUpInside)
                    button.tag = tag
                    view.addSubview(button)
                    tag += 1
            }
        }
    }
    
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

    @objc func openColor(sender: UIButton) {
        print("click")
    }
    
    // MARK: - Selectors
    
    //A new palette is generated when user taps on the Generate button
    @objc func randomPalette(sender: UIButton) {
        newPalette()
    }

    // MARK: - API Call
    func newPalette() {
        guard let url = URL(string: "https://www.colourlovers.com/api/palettes/top?format=json&numResults=20") else { return }
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
                    print("Palette color: " + colorPalette[i].colors[j])
                }
            }
        }
        return cell
    }

// MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped on me! \(colorPalette[indexPath.row].colors[indexPath.row])")
    }
}

