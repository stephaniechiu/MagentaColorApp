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
    
    let colorDetailsView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = paletteView
        
        newPalette()
        setupTableView()
        hideColor()
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
        
        view.addSubview(colorDetailsView)
    }
    
    func hideColor() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissColor))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Selectors
    
    //A new palette is generated when user taps on the Generate button
    @objc func randomPalette(sender: UIButton) {
        newPalette()
    }
    
    //Color cell expands to fill the screen of that color when user taps on the cell
    @objc func userTap(sender: UITapGestureRecognizer) {
//        colorDetailsView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 0)
//        colorDetailsView.alpha = 0

        if sender.state == UIGestureRecognizer.State.ended {
            let tapLocation = sender.location(in: self.paletteTableView)
            
            if let tapIndexPath = self.paletteTableView.indexPathForRow(at: tapLocation) {
                if let tappedCell = self.paletteTableView.cellForRow(at: tapIndexPath) {
                    var rect = tappedCell.convert(tappedCell.frame, to: self.view)
                    colorDetailsView.center = CGPoint(x: rect.origin.x + rect.size.width/2, y: rect.origin.y - rect.size.height/2)
                    
                    UIView.animate(withDuration: 1.0, animations: {
//                        self.colorDetailsView.bounds.size.height = UIScreen.main.bounds.height
//                        rect = rect.offsetBy(dx: 1, dy: 50)
                        tappedCell.transform = CGAffineTransform(scaleX: 1, y: 50)
//                        self.colorDetailsView.transform = .identity
                        
                        for i in 0..<self.colorPalette.count {
                            for j in 0..<self.colorPalette[i].colors.count {
                                if tapIndexPath.row == j {
                                    self.colorDetailsView.backgroundColor = UIColor(hexString: self.colorPalette[i].colors[j])
                                }
                            }
                        }
                    } )
                }
            }
        }

    }
    
    //Color will compress back to its cell when user taps anywhere on the screen
    @objc func dismissColor(sender: UITapGestureRecognizer) {
        print("click")
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userTap(sender:)))
        cell.addGestureRecognizer(tapGesture)
        cell.isUserInteractionEnabled = true

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped on me! \(colorPalette[indexPath.row].colors[indexPath.row])")
    }
}

