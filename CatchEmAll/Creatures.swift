//
//  Creatures.swift
//  CatchEmAll
//
//  Created by Zhejun Zhang on 3/17/25.
//

import Foundation

@Observable
class Creatures {
    private struct Returned: Codable {
        var count: Int
        var next: String
        var results: [Creature]
    }
    
    var urlString = "https://pokeapi.co/api/v2/pokemon"
    var count = 0
    var creaturesArray: [Creature] = []
    
    func getData() async {
        print("We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error: could not create an url from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                return
            }
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
        } catch {
            print("Error: could not get data from \(urlString)")
        }
    }
    
}
