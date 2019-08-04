//
//  NetworkingManager.swift
//  pokeListFromJSON
//
//  Created by bel mount on 3/8/2019.
//  Copyright © 2019 bel mount. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NetworkingManager: ObservableObject {
    
    var objectWillChange = PassthroughSubject<NetworkingManager, Never>()
    
    var pokemonList = PokemonAPIList(results:[]) {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    init() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=5") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(PokemonAPIList.self, from: data)
            
            DispatchQueue.main.async {
                self.pokemonList = pokemonList
                dump(pokemonList)
            }
        }.resume()
    }
    
    
}
