//
//  PokemonViewModel.swift
//  PikaCard
//
//  Created by Mehmet  Kulakoğlu on 23.08.2022.
//

import UIKit

struct PokemonViewModel {

    let pokemonInfo: PokemonModel
    
    var name: String? {
        return self.pokemonInfo.name?.capitalized
    }
    
    var hpValue: Int? {
        return self.pokemonInfo.stats?[0].baseStat
    }
    
    var attackValue: Int? {
        return self.pokemonInfo.stats?[1].baseStat
    }
    
    var defenseValue: Int? {
        return self.pokemonInfo.stats?[2].baseStat
    }
    
    var poster: String? {
        return self.pokemonInfo.sprites?.other?.officialArtwork?.frontDefault
    }
    
    func getImage(completion: @escaping (UIImage) -> Void) {
        
        guard let urlStr = poster,
        let url = URL(string: urlStr) else {
            completion(UIImage(named: "pokeBall")!)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(UIImage(named: "pokeBall")!)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(UIImage(named: "pokeBall")!)
                return
            }
            completion(image)
        }.resume()
    }
    
}
