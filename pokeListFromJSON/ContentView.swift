//
//  ContentView.swift
//  pokeListFromJSON
//
//  Created by bel mount on 3/8/2019.
//  Copyright © 2019 bel mount. All rights reserved.
//

import SwiftUI
import Combine


struct PokemonAPIList: Decodable {
    var results: [PokemonListEntry]
}

//MARK - Pokemon API
struct PokemonListEntry: Decodable {
    var name: String
    var url: String
}


//MARK - Content View
struct ContentView: View {
    @ObservedObject var networkingManager = NetworkingManager()
    
    var body: some View {
        print("hi there \(networkingManager.pokemonList.results.count)")
        return NavigationView {
            List(networkingManager.pokemonList.results, id: \.url) { pokemon in
                Text(pokemon.name.capitalized)
                
            }
        }

    }
}

#if DEBUG
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
