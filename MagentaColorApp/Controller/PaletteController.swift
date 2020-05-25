//
//  ViewController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class PaletteController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
// MARK: - Properties
    
    let paletteView = PaletteView()
    let paletteTableView = UITableView()
    var colorPalette = [Color]()
    var colorArray = [UIButton]()
    let cellIdentifier = "ColorCell"
    var cellColor: String = ""
    var gradientLayer = CAGradientLayer()
    
    let bottomHeight = CGFloat(80) //Height of bottom controller bar
    var currentAnimation = 0
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = paletteView
        
        newPalette()
        setupNavigationItem()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

// MARK: - Helper Functions

    fileprivate func setupNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .label
    }
    
    fileprivate func setupView() {
        paletteTableView.dataSource = self
        paletteTableView.delegate = self
        paletteTableView.isScrollEnabled = false
        
        let heightOfCells: CGFloat = (UIScreen.main.bounds.height - bottomHeight) / 5
        paletteTableView.rowHeight = heightOfCells
        
        paletteTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        paletteView.paletteGenerateButton.addTarget(self, action: #selector(randomPalette(sender:)), for: .touchUpInside)
        
        view.addSubview(paletteView.colorStackView)
        paletteView.colorStackView.centerX(inView: view)
        paletteView.colorStackView.centerY(inView: view)
        
        view.addSubview(paletteTableView)
        paletteTableView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        
        view.addSubview(paletteView.bottomControllerView)
        paletteView.bottomControllerView.anchor(top: paletteTableView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, height: bottomHeight)
    }
    
    fileprivate func setupColorDetails() {
        self.view.addSubview(self.paletteView.colorStackView)
        self.paletteView.colorStackView.centerX(inView: self.view)
        self.paletteView.colorStackView.centerY(inView: self.view)
        self.paletteView.colorStackView.alpha = 1
    }

    // MARK: - Selectors
    
    @objc func openGradientController() {
        let gradientController = GradientController()
        self.navigationController?.pushViewController(gradientController, animated: true)
    }
    
    @objc func openColor(sender: UIButton) {
        let buttonTag = sender.tag
        for i in 0..<5 {
            if buttonTag == i {
                UIView.animate(withDuration: 0.7, animations: {
                    switch self.currentAnimation {
                    case 0:
                        self.colorArray[i].transform = CGAffineTransform(scaleX: 1.1, y: 50)
                        self.colorArray[i].backgroundColor = UIColor(hexString: self.colorPalette[0].colors[i])
                        self.view.bringSubviewToFront(self.colorArray[i])
                        self.setupColorDetails()
                        self.cellColor = self.colorPalette[0].colors[i]
                        print("This is the color \(self.cellColor)")
                    case 1:
                        self.colorArray[i].transform = CGAffineTransform.identity
                        self.paletteView.colorStackView.alpha = 0
                    default:
                        break
                        }
                    })
                    currentAnimation += 1
                    if currentAnimation > 1 {
                        currentAnimation = 0
                    }
                print("click \(buttonTag)")
            }
        }
    }
    
    //A new palette is generated when user taps on the Generate button
    @objc func randomPalette(sender: UIButton) {
        newPalette()
    }

    // MARK: - API Call
    
    func newPalette() {
        guard let url = URL(string: "https://www.colourlovers.com/api/palettes/?format=json&numResults=100") else { return }
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
        
        var buttonY: CGFloat = 0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none

        //Assigns a new color to each row. Colors are converted from HEX to RGB
        for i in 0..<1 {
            var tag = 0
            for j in 0..<colorPalette[i].colors.count {
                
                let button = UIButton(frame: CGRect(x: 15, y: buttonY, width: UIScreen.main.bounds.width - 30, height: (UIScreen.main.bounds.height - 100) / 5))
                buttonY = buttonY + (UIScreen.main.bounds.height/5 - 15)
                button.addTarget(self, action: #selector(openColor(sender:)), for: .touchUpInside)
                button.layer.cornerRadius = 10
                button.tag = tag
                tag += 1

                view.addSubview(button)
                colorArray.append(button)
                
                if indexPath.row == j {
                    cell.backgroundColor? = UIColor(hexString: colorPalette[i].colors[j])
                    button.backgroundColor = UIColor(hexString: colorPalette[0].colors[indexPath.row])
                    print("Palette color: " + colorPalette[0].colors[button.tag])
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

