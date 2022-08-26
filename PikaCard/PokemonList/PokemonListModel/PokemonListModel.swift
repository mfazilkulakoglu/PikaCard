//
//  PokemonListModel.swift
//  PikaCard
//
//  Created by Mehmet  Kulakoğlu on 26.08.2022.
//

import Foundation

struct PokemonListModel: Decodable {
    
    let count: Int?
    let results: [PokemonLinkModel]?
    
}

struct PokemonLinkModel: Decodable {
    let name: String?
    let url: String?
}
