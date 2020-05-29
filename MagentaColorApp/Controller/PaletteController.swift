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
    var colorButton = [UIButton]() //Array of buttons the size and color of each tableView cell
    var arrayText = [String]()
    let cellIdentifier = "ColorCell"
    var cellColorFromAPI: String = ""
    var cellColorInRGB = UIColor()
    let bottomControllerHeight = CGFloat(80)
    var currentAnimation = 0
    let hapticFeedback = UIImpactFeedbackGenerator()
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = paletteView
        
        newPalette()
        setupNavigationController()
        setupTableView()
        setupBottomController()
    }

// MARK: - Helper Functions

    fileprivate func setupNavigationController() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .label
    }
    
    fileprivate func setupBottomController() {
        paletteView.paletteGenerateButton.addTarget(self, action: #selector(randomPalette(sender:)), for: .touchUpInside)
        paletteView.shareButton.addTarget(self, action: #selector(setupActivityViewController(sender:)), for: .touchUpInside)
        paletteView.menuButton.addTarget(self, action: #selector(openMenu(sender:)), for: .touchUpInside)
        printArray()
        
        view.addSubview(paletteView.bottomControllerView)
        paletteView.bottomControllerView.anchor(top: paletteTableView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, height: bottomControllerHeight)
    }
    
    fileprivate func setupTableView() {
        paletteTableView.dataSource = self
        paletteTableView.delegate = self
        paletteTableView.isScrollEnabled = false
        paletteTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let heightOfCells: CGFloat = (UIScreen.main.bounds.height - bottomControllerHeight) / 5
        paletteTableView.rowHeight = heightOfCells
        
        paletteTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        view.addSubview(paletteView.colorStackView)
        paletteView.colorStackView.centerX(inView: view)
        paletteView.colorStackView.centerY(inView: view)
        
        view.addSubview(paletteTableView)
        paletteTableView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    fileprivate func setupColorDetails() {
        self.view.addSubview(self.paletteView.colorStackView)
        self.view.addSubview(self.paletteView.colorShareButton)
        self.paletteView.colorShareButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: 50, paddingRight: 30, width: 35, height: 35)
        self.paletteView.colorShareButton.alpha = 1
        self.paletteView.colorStackView.centerX(inView: self.view)
        self.paletteView.colorStackView.centerY(inView: self.view)
        self.paletteView.colorStackView.alpha = 1
    }
    
        func printArray() {
    //        let buttonTag = sender.tag
            for i in 0..<5 {
                    self.cellColorFromAPI = self.colorPalette[0].colors[i]
                    arrayText.append(self.cellColorFromAPI)
            }
            print("Magenta Color App: { \n\(arrayText) \n}")
        }

    // MARK: - Selectors
    
    @objc func openGradientController() {
        let gradientController = GradientController()
        self.navigationController?.pushViewController(gradientController, animated: true)
    }
    
    @objc func setupActivityViewController(sender: UIButton) {
        let string = "Magenta Color App: { \n\(arrayText) \n}"
//        let pdf = Bundle.main.url(forResource: "Q4 Projections", withExtension: "pdf")
        let activityViewController = UIActivityViewController(activityItems: [string], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func openColor(sender: UIButton) {
        let buttonTag = sender.tag
        for i in 0..<5 {
            if buttonTag == i {
                UIView.animate(withDuration: 0.7, animations: {
                    switch self.currentAnimation {
                    case 0:
                        self.cellColorInRGB = UIColor(hexString:self.colorPalette[0].colors[i])
                        
                        self.colorButton[i].transform = CGAffineTransform(scaleX: 1.1, y: 50)
                        self.colorButton[i].backgroundColor = UIColor(hexString: self.colorPalette[0].colors[i])
                        self.view.bringSubviewToFront(self.colorButton[i])
                        self.setupColorDetails()
                        self.cellColorFromAPI = self.colorPalette[0].colors[i]
//                        self.paletteView.colorLabelHEX.text
                        
                        self.paletteView.colorLabelHEX.attributedText = "HEX: #\(self.cellColorFromAPI)".attributedStringWithBoldness(["HEX:"], fontSize: 20, characterSpacing: 1)
                        self.paletteView.colorLabelRGB.attributedText = "RGB: \(Int(self.cellColorInRGB.rgba.red)), \(Int(self.cellColorInRGB.rgba.green)), \( Int(self.cellColorInRGB.rgba.blue))".attributedStringWithBoldness(["RGB:"], fontSize: 20, characterSpacing: 1)
                        self.paletteView.colorLabelHSB.attributedText = "HSB: \(Int(self.cellColorInRGB.hsba.hue)), \(Int(self.cellColorInRGB.hsba.saturation)), \(Int(self.cellColorInRGB.hsba.brightness))".attributedStringWithBoldness(["HSB:"], fontSize: 20, characterSpacing: 1)
                        self.paletteView.colorLabelCMY.attributedText = "CMY: \(Int(round(self.cellColorInRGB.cmy.cyan * 100))), \(Int(round(self.cellColorInRGB.cmy.magenta * 100))), \(Int(round(self.cellColorInRGB.cmy.yellow * 100)))".attributedStringWithBoldness(["CMY:"], fontSize: 20, characterSpacing: 1)
                        self.paletteView.colorLabelCMYK.attributedText = "CMYK: \(Int(round(self.cellColorInRGB.cmyk.cyan * 100))), \(Int(round(self.cellColorInRGB.cmyk.magenta * 100))), \(Int(round(self.cellColorInRGB.cmyk.yellow * 100))), \(Int(round(self.cellColorInRGB.cmyk.black * 100)))".attributedStringWithBoldness(["CMYK:"], fontSize: 20, characterSpacing: 1)
                        
//                        print("This is the color \(self.cellColor)")
                    case 1:
                        self.colorButton[i].transform = CGAffineTransform.identity
                        self.paletteView.colorStackView.alpha = 0
                        self.paletteView.colorShareButton.alpha = 0
                    default:
                        break
                        }
                    })
                    currentAnimation += 1
                    if currentAnimation > 1 {
                        currentAnimation = 0
                    }
//                print("click \(buttonTag)")
            }
        }
    }
    
    //A new palette is generated when user taps on the Generate button
    @objc func randomPalette(sender: UIButton) {
        newPalette()
        hapticFeedback.impactOccurred()
    }
    
    @objc func openMenu(sender: UIButton) {
        
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
                button.layer.borderColor = UIColor.clear.cgColor
                button.tag = tag
                tag += 1

                view.addSubview(button)
                colorButton.append(button)
                
                if indexPath.row == j {
                    cell.backgroundColor? = UIColor(hexString: colorPalette[i].colors[j])
                    button.backgroundColor = UIColor(hexString: colorPalette[0].colors[indexPath.row])
//                    print("Palette color: " + colorPalette[0].colors[button.tag])
                }
            }
        }
        return cell
    }

// MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("you tapped on me! \(colorPalette[indexPath.row].colors[indexPath.row])")
    }
}

