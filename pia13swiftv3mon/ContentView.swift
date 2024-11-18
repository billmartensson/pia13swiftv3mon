//
//  ContentView.swift
//  pia13swiftv3mon
//
//  Created by BillU on 2024-11-18.
//

import SwiftUI

struct ChuckJoke : Codable {
    var id : String
    var url : String
    var value : String
}


struct ContentView: View {
    
    @State var joke : ChuckJoke?
    @State var jokecategories : [String]?
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                if let joke {
                    Text(joke.id)
                    Text(joke.value)
                }
                
                Button(action: {
                    Task {
                        await loadjoke()
                    }
                }) {
                    Text("Load random joke")
                }
                
                if let jokecategories {
                    List(jokecategories, id: \.self) { cat in
                        
                        NavigationLink(destination: CategoryView(categoryname: cat)) {
                            Text(cat)
                        }
                        
                    }
                    
                }
                
            } // VStack
            .padding()
            .task {
                await loadjoke()
                await loadcategories()
            }
            
        } // nav stack
    } // body
    
    func loadjoke() async {
        let jokeurl = URL(string: "https://api.chucknorris.io/jokes/random")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeurl)

            if let jokedata = try? JSONDecoder().decode(ChuckJoke.self, from: data) {
                
                joke = jokedata
            }
        } catch {
            print("Invalid data")
        }
    }
    
    func loadcategories() async {
        let jokeurl = URL(string: "https://api.chucknorris.io/jokes/categories")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeurl)

            if let categories = try? JSONDecoder().decode([String].self, from: data) {
                
                jokecategories = categories
            }
        } catch {
            print("Invalid data")
        }
    }
    
}

#Preview {
    ContentView()
}
