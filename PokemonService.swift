//
//  PokemonService.swift
//  PokemonAPI
//
//  Created by COTEMIG on 03/11/25.
//

import Foundation

class PokemonService {
    
    func fetchPokemon(by nameOrId: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(nameOrId.lowercased())"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL inválida."])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Nenhum dado encontrado."])))
                return
            }
            
            do {
                if let pokemonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // Parse the response into a Pokemon object
                    if let pokemon = self.parsePokemonData(pokemonData) {
                        completion(.success(pokemon))
                    } else {
                        completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Erro ao processar os dados."])))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // Função para mapear os dados JSON
    private func parsePokemonData(_ data: [String: Any]) -> Pokemon? {
        guard let name = data["name"] as? String,
              let id = data["id"] as? Int,
              let height = data["height"] as? Int,
              let weight = data["weight"] as? Int,
              let types = data["types"] as? [[String: Any]],
              let sprites = data["sprites"] as? [String: Any],
              let imageUrl = sprites["front_default"] as? String else {
                  return nil
              }
        

        let typeNames = types.compactMap { typeDict in
            return typeDict["type"] as? [String: Any]
        }.compactMap { $0["name"] as? String }
        
        return Pokemon(name: name, id: id, height: height, weight: weight, types: typeNames, imageUrl: imageUrl)
    }
}
