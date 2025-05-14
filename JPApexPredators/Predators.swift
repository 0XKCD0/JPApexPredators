//
//  Predators.swift
//  JPApexPredators
//
//  Created by Shivangi Dutta on 12/05/25.
//
import Foundation

class Predators {
    var apexPredators: [ApexPredators] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredators = try decoder.decode([ApexPredators].self, from: data)
                
            }catch {
                print("Error decoding JSON data: \(error)")
                
            }
            
        }
    }
    
    func search(for searchTerm : String) -> [ApexPredators] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchTerm)
                
            }
        }
    }
    
    func sort(by alphabetical: Bool){
        apexPredators.sort { predators1, predators2 in
            if alphabetical{
                predators1.name < predators2.name
            }else{
                predators1.id < predators2.id
            }
        }
    }
    
    func filter(by type : APType){
        if type == .all {
            
        } else {
            apexPredators = apexPredators.filter { predator in
                predator.type == type
            }
        }
    }
}
