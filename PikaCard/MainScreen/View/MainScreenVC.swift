//
//  ViewController.swift
//  PikaCard
//
//  Created by Mehmet  Kulakoğlu on 23.08.2022.
//

import UIKit

class MainScreenVC: UIViewController, PokemonCardTappedDelegate {
    
    private var loadingCartView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 36
        return view
    }()
    
    var firstPokemonCard = PokemonCardView()
    var secondPokemonCard = PokemonCardView()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search with name..."
        searchBar.layer.masksToBounds = true
        searchBar.layer.cornerRadius = 12
        searchBar.backgroundColor = .white
        return searchBar
    }()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "SFCompactRounded-Regular", size: 24)
        label.text = "Loading..."
        label.backgroundColor = .systemBackground
        label.frame = CGRect(x: 30, y: 226, width: 240, height: 29)
        return label
    }()
    
    private let restartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 24
        button.setImage(UIImage(named: "ic-restart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(named: "LightPurple")
        return button
    }()
    
    private let shuffleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 24
        button.setBackgroundImage(UIImage(systemName: "shuffle.circle.fill"), for: .normal)
        button.backgroundColor = UIColor(named: "LightPurple")
        button.tintColor = .white
        return button
    }()
    
    private var count: Int?
    private var id: Int = 0
    private var firstCardShow: Bool = false
    private var isCardsShuffled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeHideKeyboard()
        
        getCount()
        
        
        view.backgroundColor = UIColor(named: "LightPurple")
        
        firstPokemonCard = PokemonCardView(frame: loadingCartView.frame)
        secondPokemonCard = PokemonCardView(frame: loadingCartView.frame)
        
        firstPokemonCard.didTapDelegate = self
        secondPokemonCard.didTapDelegate = self
        
        searchBar.delegate = self
        
        restartButton.addTarget(self,
                                action: #selector(restart),
                                for: .touchUpInside)
        
        shuffleButton.addTarget(self,
                                action: #selector(shuffle),
                                for: .touchUpInside)
        
        addSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            restart()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loadingCartView.frame = CGRect(x: 45,
                                       y: 180,
                                       width: view.width - 90,
                                       height: view.height - 360)
        
        loadingLabel.frame = CGRect(x: 30,
                                    y: 226,
                                    width: 240,
                                    height: 29)
        
        restartButton.frame = CGRect(x: 16,
                                     y: 48,
                                     width: 48,
                                     height: 48)
        
        shuffleButton.frame = CGRect(x: view.width - 64,
                                     y: restartButton.top,
                                     width: 48,
                                     height: 48)
        
        searchBar.frame = CGRect(x: 16,
                                 y: restartButton.bottom + 20,
                                 width: view.width - 32,
                                 height: 42)
        
    }
    
    private func addSubviews() {
        view.addSubview(loadingCartView)
        view.addSubview(restartButton)
        view.addSubview(shuffleButton)
        view.addSubview(searchBar)
        loadingCartView.addSubview(loadingLabel)
    }
    
    func getCount() {
        
        PokemonService.shared.getCount { result in
            switch result {
            case .failure(_):
                break
            case .success(let count):
                self.count = count
            }
        }
        
    }
    
    @objc func restart() {
        
        self.isCardsShuffled = false
        self.id = 0
        self.firstCardShow = false
        
        flipCard()
    }
    
    
    func flipCard() {
        
        hideKeyboard()
        self.searchBar.text = ""
        
        guard let count = count,
              id < count else {
            return
        }
        
        if isCardsShuffled {
            id = Int.random(in: 1...count)
        } else {
            id += 1
        }
        
        PokemonService.shared.downloadPokemonInfo(name: nil, id: id) { result in
            switch result {
            case .failure(_):
                break
            case .success(let model):
                let pokemon = PokemonViewModel(pokemonInfo: model)
                DispatchQueue.main.async {
                    switch self.firstCardShow {
                        
                    case true:
                        
                        self.secondPokemonCard.showCard(on: self)
                        self.flipLeftToRight(view1: self.firstPokemonCard.cardView, view2: self.secondPokemonCard.cardView)
                        self.secondPokemonCard.loadInfo(with: pokemon)
                        self.firstPokemonCard.layer.isDoubleSided = false
                        self.firstCardShow = false
                        
                    case false:
                        
                        self.firstPokemonCard.showCard(on: self)
                        self.flipDownToUp(view1: self.secondPokemonCard.cardView, view2: self.firstPokemonCard.cardView)
                        self.firstPokemonCard.loadInfo(with: pokemon)
                        self.secondPokemonCard.layer.isDoubleSided = false
                        self.firstCardShow = true
                        self.loadingCartView.isHidden = true
                    }
                }
            }
        }
    }
    
    
    
    @objc func shuffle() {
        if !isCardsShuffled {
            isCardsShuffled = true
            self.shuffleButton.tintColor = .darkGray
            flipCard()
        } else {
            isCardsShuffled = false
            self.shuffleButton.tintColor = .white
        }
    }
    
}

extension MainScreenVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else {
            return
        }
        
        PokemonService.shared.downloadPokemonInfo(name: searchText, id: nil) { result in
            switch result {
            case .failure(_):
                break
            case .success(let model):
                let pokemon = PokemonViewModel(pokemonInfo: model)
                self.firstPokemonCard.loadInfo(with: pokemon)
                self.firstPokemonCard.showCard(on: self)
                self.firstCardShow = true
            }
        }
    }
}
