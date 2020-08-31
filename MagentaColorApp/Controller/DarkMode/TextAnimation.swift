//
//  TextFade.swift
//  
//
//  Created by Stephanie on 8/30/20.
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
    
    func springAnimation(sender: UIButton) {
        //Spring animation to button
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: CGFloat(0.2), initialSpringVelocity: CGFloat(4.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            sender.transform = CGAffineTransform.identity
        }, completion: {
            Void in()
        })
    }
    
}
