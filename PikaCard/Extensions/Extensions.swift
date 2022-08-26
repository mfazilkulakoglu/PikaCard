//
//  Extensions.swift
//  PikaCard
//
//  Created by Mehmet  Kulakoğlu on 23.08.2022.
//

import UIKit
import SwiftUI

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
  func addTapGesture(tapNumber: Int, target: Any, action: Selector) {
    let tap = UITapGestureRecognizer(target: target, action: action)
    tap.numberOfTapsRequired = tapNumber
    addGestureRecognizer(tap)
    isUserInteractionEnabled = true
  }
}


extension UIViewController {
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func initializeHideKeyboard() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer.cancelsTouchesInView = true
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}

extension Font {
    
    static var pokemonNameFont: Font {
        return Font.custom("SF-Compact-Rounded-Regular", size: 24)
    }
    
    static var pokemonStatNameFont: Font {
        return Font.custom("SF-Compact-Rounded-Regular", size: 18)
    }
    
    static var pokemonStatValueFont: Font {
        return Font.custom("SF-Compact-Rounded-Medium", size: 32)
    }
}
