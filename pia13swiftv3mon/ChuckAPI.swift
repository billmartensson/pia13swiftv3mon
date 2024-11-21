//
//  ChuckAPI.swift
//  pia13swiftv3mon
//
//  Created by BillU on 2024-11-21.
//

import Foundation
import SwiftUI

@Observable class ChuckAPI {
    
    var joke : ChuckJoke?
    var jokecategories : [String] = []
    
    var isLoading : Bool = false
    
    func loadjoke() async {
        isLoading = true
        let jokeurl = URL(string: "https://api.chucknorris.io/jokes/random")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeurl)

            if let jokedata = try? JSONDecoder().decode(ChuckJoke.self, from: data) {
                
                joke = jokedata
            }
            isLoading = false
        } catch {
            print("Invalid data")
        }
    }
    
    func loadcategories() async {
        isLoading = true
        
        let jokeurl = URL(string: "https://api.chucknorris.io/jokes/categories")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeurl)

            if let categories = try? JSONDecoder().decode([String].self, from: data) {
                
                jokecategories = categories
                
            }
            isLoading = false
        } catch {
            print("Invalid data")
        }
    }
    
    func makesearch(searchtext : String) async {
        isLoading = true
        
        let jokeurl = URL(string: "https://api.chucknorris.io/jokes/search?query=\(searchtext)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeurl)

            if let searchresult = try? JSONDecoder().decode(ChuckSearch.self, from: data) {
                
                if searchresult.result.count > 0 {
                    joke = searchresult.result[0]
                }
            }
            isLoading = false
        } catch {
            print("Invalid data")
        }
    }
    
    func loadjokeCategory(categoryname : String) async {
        isLoading = true
        let jokeurl = URL(string: "https://api.chucknorris.io/jokes/random?category=\(categoryname)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeurl)

            if let jokedata = try? JSONDecoder().decode(ChuckJoke.self, from: data) {
                
                joke = jokedata
            }
            isLoading = false
        } catch {
            print("Invalid data")
        }
    }
}
