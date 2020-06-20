//
//  AlertPopUpView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/19/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class AlertPopUpView: UIView {
    
    // MARK: - Properties
    
    let popupView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 150, height: 150)
        view.backgroundColor = .systemGray2
        view.layer.cornerRadius = 10
        
        let titleLabel = UILabel()
        titleLabel.text = "Add a favorite"
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Click on the heart on the palette or gradient screens to add your first one"
        subtitleLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 12)
        subtitleLabel.lineBreakMode = .byWordWrapping
        
        let button = UIButton()
        button.backgroundColor = .magenta
        button.titleLabel?.textAlignment = .center
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.addTarget(self, action: #selector(dismiss(sender:÷)), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, paddingTop: 5)
        titleLabel.centerX(inView: view)
        
        view.addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 5)
        subtitleLabel.centerX(inView: view)
        
        view.addSubview(button)
        button.anchor(bottom: view.bottomAnchor, width: 150, height: 30)
        
        return view
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func setupLayout() {
        addSubview(popupView)
        popupView.centerX(inView: self)
        popupView.centerY(inView: self)
    }
    
    // MARK: - Selectors
    
//    @objc func dismiss(sender: UIBarButtonItem) {
//        self.dismiss(animated: true, completion: nil)
//    }
}
