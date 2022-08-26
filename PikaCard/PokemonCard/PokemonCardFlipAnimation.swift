//
//  PokemonCardFlipAnimation.swift
//  PikaCard
//
//  Created by Mehmet  Kulakoğlu on 25.08.2022.
//

import UIKit

extension UIViewController {
    
    func flipLeftToRight(view1: UIView, view2: UIView) {
        DispatchQueue.main.async {
//            UIView.transition(from: view1.cardView, to: view2.cardView, duration: 2, options: .transitionFlipFromLeft)
            
            UIView.animate(withDuration: 2, delay: 0, options: .transitionFlipFromLeft, animations: {
                let animation1 = CABasicAnimation(keyPath: "transform.rotation.y")
                animation1.fromValue = 0
                animation1.toValue = CGFloat.pi * 1
                animation1.duration = 2
                animation1.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

                DispatchQueue.main.async {
                    view1.layer.add(animation1, forKey: nil)
                    view2.layer.add(animation1, forKey: nil)
                }
                
            }, completion: nil)

        }        
    }
    
    
    func flipDownToUp(view1: UIView, view2: UIView) {
        
        DispatchQueue.main.async {

            
            UIView.animate(withDuration: 2, delay: 0, options: .transitionFlipFromLeft, animations: {
                let animation1 = CABasicAnimation(keyPath: "transform.rotation.x")
                animation1.fromValue = 0
                animation1.toValue = CGFloat.pi * 1
                animation1.duration = 2
                animation1.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

                DispatchQueue.main.async {
                    view1.layer.add(animation1, forKey: nil)
                    view2.layer.add(animation1, forKey: nil)
                }
                
            }, completion: nil)

        }
        

    }
    
}
