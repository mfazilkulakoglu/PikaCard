//
//  PokemonCardView.swift
//  PikaCard
//
//  Created by Mehmet  Kulakoğlu on 23.08.2022.
//

import UIKit

protocol PokemonCardTappedDelegate: AnyObject {
    func flipCard()
}

class PokemonCardView: UIView {
    
    weak var didTapDelegate: PokemonCardTappedDelegate?
    
    public let cardView: UIView = {
        let card = UIView()
        card.backgroundColor = .white
        card.layer.masksToBounds = true
        card.layer.cornerRadius = 36
        return card
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFCompactRounded-Regular", size: 24)
        label.backgroundColor = .systemBackground
        return label
    }()
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let hpLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFCompactRounded-Regular", size: 18)
        label.text = "hp"
        return label
    }()
    
    private let attackLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFCompactRounded-Regular", size: 18)
        label.text = "attack"
        return label
    }()
    
    private let defenseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFCompactRounded-Regular", size: 18)
        label.text = "defense"
        return label
    }()
    
    public let hpValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFCompactRounded-Medium", size: 32)
        return label
    }()
    
    public let attackValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFCompactRounded-Medium", size: 32)
        return label
    }()
    
    public let defenseValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFCompactRounded-Medium", size: 32)
        return label
    }()
    
    private var myTargetView: UIView?
    private var viewController: UIViewController?
    
    
    @objc func didTapCard(gesture: UITapGestureRecognizer) -> Void {
        didTapDelegate?.flipCard()
    }
    
    
    
    func showCard(on viewController: UIViewController?) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
            
            guard let targetView = viewController?.view else {
                return
            }
            
            self.cardView.addTapGesture(tapNumber: 1, target: self, action: #selector(didTapCard(gesture:)))
            
            self.myTargetView = targetView
            self.viewController = viewController
            
            
            cardView.frame = CGRect(x: 45,
                                    y: 180,
                                    width: targetView.width - 90,
                                    height: targetView.height - 360)
            
            titleLabel.frame = CGRect(x: 30,
                                      y: 18,
                                      width: 240,
                                      height: 29)
            
            imageView.frame = CGRect(x: 99,
                                     y: 183,
                                     width: 101.95,
                                     height: 114)
            
            hpLabel.frame = CGRect(x: 18,
                                   y: 398,
                                   width: 88,
                                   height: 21)
            
            attackLabel.frame = CGRect(x: 106,
                                       y: 398,
                                       width: 88,
                                       height: 21)
            
            defenseLabel.frame = CGRect(x: 194,
                                        y: 398,
                                        width: 88,
                                        height: 21)
            
            hpValueLabel.frame = CGRect(x: 18,
                                        y: 419,
                                        width: 88,
                                        height: 38)
            
            attackValueLabel.frame = CGRect(x: 106,
                                            y: 419,
                                            width: 88,
                                            height: 38)
            
            defenseValueLabel.frame = CGRect(x: 194,
                                             y: 419,
                                             width: 88,
                                             height: 38)
            
            
            targetView.addSubview(cardView)
            cardView.addSubview(titleLabel)
            cardView.addSubview(imageView)
            cardView.addSubview(hpLabel)
            cardView.addSubview(attackLabel)
            cardView.addSubview(defenseLabel)
            cardView.addSubview(hpValueLabel)
            cardView.addSubview(attackValueLabel)
            cardView.addSubview(defenseValueLabel)
            
        }
    }
    
    func loadInfo(with model: PokemonViewModel) {
        
        DispatchQueue.main.async { [self] in
            guard let pokemonName: String = model.name else {
                titleLabel.text = "Unkonwn"
                return
            }
            titleLabel.text = pokemonName
            
            model.getImage(completion: { image in
                
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
                
            })
            
            
            guard let hpValue = model.hpValue else {
                return
            }
            
            hpValueLabel.text = String(hpValue)
            
            guard let attackValue = model.attackValue else {
                return
            }
            
            attackValueLabel.text = String(attackValue)
            
            guard let defenseValue = model.defenseValue else {
                return
            }
            
            defenseValueLabel.text = String(defenseValue)
        }
    }
}
