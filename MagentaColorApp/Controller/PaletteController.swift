 //
//  ViewController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import CloudKit

class PaletteController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate {
    
// MARK: - Properties
    
    let paletteView = PaletteView()
    let swipeGesture = SwipeGesture()
    let paletteTableView = UITableView()
    var colorPalette = [Color]()
    var colorButton = [UIButton]() //Array of buttons the size and color of each tableView cell
    var appendedPalettes: [Color] {
        var appendedPalette: [Color]!
        concurrentPalettesQueue.sync {
            appendedPalette = self.colorPalette
        }
        return appendedPalette
    }
    var arrayText = [String]()
    let cellIdentifier = "ColorCell"
    var cellColorFromAPI: String = ""
    var cellColorInRGB = UIColor()
    let bottomControllerHeight = CGFloat(80)
    var currentAnimation = 0
    let hapticFeedback = UIImpactFeedbackGenerator()
    let pasteboard = UIPasteboard.general
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let start = Date()
        
        view = paletteView
        
        newPalette()
        setupNavigationController()
        setupTableView()
        setupBottomController()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let end = Date()
        print("Elapsed Time at start of app: \(end.timeIntervalSince(start))")
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

    func setupNavigationController() {
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "BackButton_blank")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "BackButton_blank")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .label
    }
    
    func setupBottomController() {
        paletteView.menuButton.addTarget(self, action: #selector(openMenu(sender:)), for: .touchUpInside)
        paletteView.shareButton.addTarget(self, action: #selector(setupPaletteActivityViewController), for: .touchUpInside)
        paletteView.paletteGenerateButton.addTarget(self, action: #selector(randomPalette(sender:)), for: .touchUpInside)
//        paletteView.favoriteButton.addTarget(self, action: #selector(saveFavoritePalette(sender:)), for: .touchUpInside)
        
        //Check if user is subscribed. If no subscription, then show Premium Controller
//        let checkForSubscription = UserDefaults.standard.bool(forKey: IAPProduct.nonConsumablePurchase.rawValue)
//        if (!checkForSubscription) {
//            paletteView.favoriteButton.addTarget(self, action: #selector(openPremium(sender:)), for: .touchUpInside)
////                menuView.favoritesButton.alpha = 0
////                menuView.favoritesButton.isHidden = true
//        }
        
        view.addSubview(paletteView.bottomControllerView)
        paletteView.bottomControllerView.anchor(top: paletteTableView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, height: bottomControllerHeight)
    }
    
    func setupTableView() {
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
    
    //UI of the view when a color is tapped on
    func setupColorLayout() {
        self.view.addSubview(self.paletteView.colorStackView)
        self.paletteView.colorStackView.centerX(inView: self.view)
        self.paletteView.colorStackView.centerY(inView: self.view)
        self.paletteView.colorStackView.alpha = 1
        
        self.view.addSubview(self.paletteView.colorShareButton)
        self.paletteView.colorShareButton.anchor(top: self.view.topAnchor, right: self.view.rightAnchor, paddingTop: 50, paddingRight: 30, width: 35, height: 35)
        self.paletteView.colorShareButton.alpha = 0.5
        self.paletteView.colorShareButton.addTarget(self, action: #selector(setupColorActivityViewController(sender:)), for: .touchUpInside)
        
        self.view.addSubview(paletteView.copiedNotificationLabel)
        self.paletteView.copiedNotificationLabel.centerX(inView: self.view)
        self.paletteView.copiedNotificationLabel.anchor(top: self.view.topAnchor, paddingTop: 10, width: 20, height: 10)
    }

    //Determines the color contrast of the share button against the cell color background
    func contrastColorForIcon(color: UIColor) {
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
    
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let luminance = 1 - ((0.299 * r) + (0.587 * g) + (0.114 * b))
        if luminance < 0.5 {
            paletteView.colorShareButton.setImage(#imageLiteral(resourceName: "share-office-color-black"), for: .normal)
        } else {
            paletteView.colorShareButton.setImage(#imageLiteral(resourceName: "share-office-color-white"), for: .normal)
        }
    }

    // MARK: - Selectors
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
    if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        let gradientController = GradientController()
        let menuController = MenuController()
        
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            self.navigationController?.pushViewControllerFromLeft(controller: menuController)
            print("Swiped right")
        case UISwipeGestureRecognizer.Direction.left:
            self.navigationController?.pushViewController(gradientController, animated: true)
            print("Swiped left")
        default:
            break
            }
        }
    }
    
    @objc func openGradientController() {
        let gradientController = GradientController()
        self.navigationController?.pushViewController(gradientController, animated: true)
    }
    
    @objc func openMenu(sender: UIButton) {
        let menuController = MenuController()
        self.navigationController?.pushViewControllerFromLeft(controller: menuController)
    }
    
    @objc func openPremium(sender: UIButton) {
        let premiumController = PremiumController()
        self.present(premiumController, animated: true, completion: nil)
    }
    
    //User is able to share all the colors in view
    @objc func setupPaletteActivityViewController(sender: UIButton) {
        let string = "Magenta Color App: \n\(arrayText) \n".replacingOccurrences(of: ",", with:"\n", options: .literal, range: nil)
        let activityViewController = UIActivityViewController(activityItems: [string], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    //User is able to share individual color
    @objc func setupColorActivityViewController(sender: UIButton) {
        let string = "Magenta Color App: \(cellColorInRGB.toHexString().uppercased())"
        print(cellColorFromAPI)
        let activityViewController = UIActivityViewController(activityItems: [string], applicationActivities: nil)
            
        present(activityViewController, animated: true, completion: nil)
    }
    
//    @objc func copyText(sender: UIGestureRecognizer) {
//        UIPasteboard.general.string = paletteView.colorLabelHEX.text
//        UIPasteboard.general.string = paletteView.colorLabelRGB.text
//        UIPasteboard.general.string = paletteView.colorLabelHSB.text
//        UIPasteboard.general.string = paletteView.colorLabelCMY.text
//        UIPasteboard.general.string = paletteView.colorLabelCMYK.text
//
//        let alert = UIAlertController(title: "Copied!", message: "", preferredStyle: UIAlertController.Style.alert)
//        self.present(alert, animated: true, completion: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//              alert.dismiss(animated: true, completion: nil)
//          }
//    }
    
    //When user taps on a color in the palette, it "opens" to fill the screen with that color with it's color codes
    @objc func openColor(sender: UIButton) {
        let buttonTag = sender.tag
        
        for i in 0..<5 {
            if buttonTag == i {
                UIView.animate(withDuration: 0.5, animations: {
                    switch self.currentAnimation {
                    case 0:
                        self.cellColorInRGB = UIColor(hexString: self.appendedPalettes[0].colors[i])
//                        print("Button color: \(self.cellColorInRGB)")
//                        print("First palette color: \(self.appendedPalettes[0].colors[i])")
                        
                        self.colorButton[i].transform = CGAffineTransform(scaleX: 1.1, y: 50)
                        self.colorButton[i].backgroundColor = UIColor(hexString: self.appendedPalettes[0].colors[i])
                        self.view.bringSubviewToFront(self.colorButton[i])
                        
                        //UI of a color cell when it is "opened"
                        self.setupColorLayout()
                        
                        //Determines the color contrast of the share button against the cell color background
                        self.contrastColorForIcon(color: self.cellColorInRGB)
                        
                        self.paletteView.colorLabelHEX.textColor = UIColor().contrastColor(color: self.cellColorInRGB)
                        self.paletteView.colorLabelHEX.attributedText = "HEX \n\(self.cellColorInRGB.toHexString().uppercased())".attributedStringWithBoldness(["HEX"], characterSpacing: 1)
               
                        self.paletteView.colorLabelRGB.textColor = UIColor().contrastColor(color: self.cellColorInRGB)
                        self.paletteView.colorLabelRGB.attributedText = "RGB \n\(Int(self.cellColorInRGB.rgba.red)), \(Int(self.cellColorInRGB.rgba.green)), \( Int(self.cellColorInRGB.rgba.blue))".attributedStringWithBoldness(["RGB"], characterSpacing: 1)
                        
                        self.paletteView.colorLabelHSB.textColor = UIColor().contrastColor(color: self.cellColorInRGB)
                        self.paletteView.colorLabelHSB.attributedText = "HSB \n\(Int(self.cellColorInRGB.hsba.hue)), \(Int(self.cellColorInRGB.hsba.saturation)), \(Int(self.cellColorInRGB.hsba.brightness))".attributedStringWithBoldness(["HSB"], characterSpacing: 1)
                        
                        self.paletteView.colorLabelCMY.textColor = UIColor().contrastColor(color: self.cellColorInRGB)
                        self.paletteView.colorLabelCMY.attributedText = "CMY \n\(Int(round(self.cellColorInRGB.cmy.cyan * 100))), \(Int(round(self.cellColorInRGB.cmy.magenta * 100))), \(Int(round(self.cellColorInRGB.cmy.yellow * 100)))".attributedStringWithBoldness(["CMY"], characterSpacing: 1)
                        
                        self.paletteView.colorLabelCMYK.textColor = UIColor().contrastColor(color: self.cellColorInRGB)
                        self.paletteView.colorLabelCMYK.attributedText = "CMYK \n\(Int(round(self.cellColorInRGB.cmyk.cyan * 100))), \(Int(round(self.cellColorInRGB.cmyk.magenta * 100))), \(Int(round(self.cellColorInRGB.cmyk.yellow * 100))), \(Int(round(self.cellColorInRGB.cmyk.black * 100)))".attributedStringWithBoldness(["CMYK"], characterSpacing: 1)
                        
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
            }
        }
    }
    
    //A new palette is generated when user taps on the Generate button
    @objc func randomPalette(sender: UIButton) {
        let randomStart = Date()
        
        sender.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
        
//        paletteView.favoriteButton.setImage(#imageLiteral(resourceName: "favourite-pink"), for: .selected)
        newPalette()
        hapticFeedback.impactOccurred()
        let randomEnd = Date()
        
        print("Elapsed Time after click: \(randomEnd.timeIntervalSince(randomStart))")
    }

    // MARK: - API Call
    
    private let concurrentPalettesQueue =
        DispatchQueue(label: "com.stephaniechiu.Magenta.PalettesQueue", attributes: .concurrent)
    
    func newPalette() {
        
        //Retrieve JSON data in background thread. Write method to modify array object
        concurrentPalettesQueue.async(flags: .barrier) {
            [weak self] in
            guard let self = self else {
                return
            }
            
            guard let url = URL(string: "https://www.colourlovers.com/api/palettes/?format=json&numResults=50") else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Palette.self, from: data)
                self.colorPalette = jsonData.shuffled()
//                self.appendedPalettes = self.colorPalette.shuffled()
//                self.arrayText.append(self.cellColorFromAPI)
                
                //Present UI into the UI
                DispatchQueue.main.async{
                    [weak self] in
                    self?.paletteTableView.reloadData()
                }
    //            print(appendedPalettes)
            } catch let jsonError {
                    print("JSON Error: ", jsonError)
                }
        }
    }
    
// MARK: - Data Persistance
    
//    @objc func saveFavoritePalette(sender: UIButton) {
//        
//        hapticFeedback.impactOccurred()
//        
//    //Favorite button will change from empty heart to filled heart when user taps to save. If user taps on game palette before generating a new palette, then that record will delete
//        if sender.isSelected {
//            sender.isSelected = false
//            paletteView.favoriteButton.setImage(#imageLiteral(resourceName: "favourite-pink"), for: .selected)
//            
//            let recordID = recordIDs.first!
//            
//            privateDatabase.delete(withRecordID: recordID) { (deleteRecordID, error) in
//                if error == nil {
//                    print("Record deleted")
//                } else {
//                    print("Record unable to delete: \(String(describing: error))")
//                }
//            }
//        } else {
//            sender.isSelected = true
//            paletteView.favoriteButton.setImage(#imageLiteral(resourceName: "favourite-filled"), for: .selected)
//            
//            saveToCloud(palette: arrayText)
//        }
//        
//        
//    }
    
    func saveToCloud(palette: [String]) {
        let record = CKRecord(recordType: "Favorite")
        record.setValue(palette, forKey: "FavoritePalette")
        
        privateDatabase.save(record) { (savedRecord, error) in
            if error == nil {
                print("Record saved")
                recordIDs.append(record.recordID)
            } else {
                print("Record not saved: \(String(describing: error))")
            }
        }
    }
    
// MARK: - TableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstPalette = appendedPalettes[0]
        var buttonY: CGFloat = 0
        var tag = 0
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        
        arrayText = firstPalette.colors
//        print(arrayText)
        
        //Assigns a new color to each row. Colors are converted from HEX to RGB
        for j in 0..<5 {
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
                cell.backgroundColor? = UIColor(hexString: firstPalette.colors[j])
                button.backgroundColor = UIColor(hexString: firstPalette.colors[indexPath.row])
//                print("Palette color: " + firstPalette.colors[button.tag])
            }
        }
        return cell
    }
}

