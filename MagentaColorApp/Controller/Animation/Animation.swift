//
//  Animation.swift
//  MagentaColorApp
//
//  Created by Stephanie on 8/30/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class Animation {
    
    let gradientView = GradientView()
    
    //Cross fade animation transition each time Generate button is tapped
    func textFadeAnimation() {
         gradientView.colorLabelLeftHEX.fadeTransition(0.4)
         gradientView.colorLabelLeftRGB.fadeTransition(0.4)
         gradientView.colorLabelLeftHSB.fadeTransition(0.4)
         gradientView.colorLabelLeftCMY.fadeTransition(0.4)
         gradientView.colorLabelLeftCMYK.fadeTransition(0.4)
         
         gradientView.colorLabelRightHEX.fadeTransition(0.4)
         gradientView.colorLabelRightRGB.fadeTransition(0.4)
         gradientView.colorLabelRightHSB.fadeTransition(0.4)
         gradientView.colorLabelRightCMY.fadeTransition(0.4)
         gradientView.colorLabelRightCMYK.fadeTransition(0.4)
    }
}

