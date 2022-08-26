//
//  PokemonService.swift
//  PikaCard
//
//  Created by Mehmet  Kulakoğlu on 23.08.2022.
//

import Foundation

class PokemonService {
    
    static let shared = PokemonService()
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon"
    
    func getCount(completion: @escaping (Result<Int, FetchError>) -> Void) {
        let urlString = baseURL + "?limit=1&offset=0"
        guard let url = URL(string: urlString) else {
            completion(.failure(.countUrlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                  error == nil else {
                completion(.failure(.countDownloadError))
                return
            }
            
            guard let pokemonList = try? JSONDecoder().decode(PokemonListModel.self, from: data),
                  let count = pokemonList.count else {
                completion(.failure(.countParseError))
                return
            }
            
            completion(.success(count))
            
            
        }.resume()
    }
    
    func downloadPokemonInfo(name: String?, id: Int?, completion: @escaping (Result<PokemonModel, FetchError>) -> Void) {
        var str = "/"
        
        if let name = name {
            str += name.lowercased()
        } else if let id = id {
            str += String(id)
        }
        
        let urlString = baseURL + str
        guard let url = URL(string: urlString) else {
            completion(.failure(.pokemonUrlError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                  error == nil else {
                completion(.failure(.pokemonDownloadError))
                return
            }
            
            guard let pokemon = try? JSONDecoder().decode(PokemonModel.self, from: data) else {
                
                completion(.failure(.pokemonParseError))
                return
            }
            
            completion(.success(pokemon))
            
            
        }.resume()
    }
    
}


public enum FetchError: Error {
    case countUrlError
    case countDownloadError
    case countParseError
    case pokemonUrlError
    case pokemonDownloadError
    case pokemonParseError
}



