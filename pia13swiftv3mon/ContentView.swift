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

struct ChuckSearch : Codable {
    var total : Int
    let result : [ChuckJoke]
}

struct ContentView: View {
    
    @State var joke : ChuckJoke?
    @State var jokecategories : [String] = []
    
    @State var isLoading : Bool = false
    
    @State var searchtext = ""
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                VStack {
                    
                    HStack {
                        TextField("Search", text: $searchtext)
                        Button(action: {
                            Task {
                                await makesearch()
                            }
                        }) {
                            Text("Search")
                        }
                    }
                    
                    if let joke {
                        Text(joke.id)
                        Text(joke.value)
                            .frame(height: 200.0)
                    }
                    
                    Button(action: {
                        Task {
                            isLoading = true
                            await loadjoke()
                            isLoading = false
                        }
                    }) {
                        Text("Load random joke")
                    }
                    
                    
                    List(jokecategories, id: \.self) { cat in
                        
                        NavigationLink(destination: CategoryView(categoryname: cat)) {
                            Text(cat)
                        }
                        
                    }
                    
                    
                    
                } // VStack
                .padding()
                .task {
                    isLoading = true
                    await loadjoke()
                    await loadcategories()
                    isLoading = false
                }
                
                if isLoading {
                    ZStack {
                        VStack {
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .opacity(0.5)
                        
                        VStack {
                            Text("LOADING....")
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 200.0, height: 200.0)
                        .background(Color("FancyRed"))
                    }
                }
                
            } // ZSTACK
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
    
    func makesearch() async {
        let jokeurl = URL(string: "https://api.chucknorris.io/jokes/search?query=\(searchtext)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeurl)

            if let searchresult = try? JSONDecoder().decode(ChuckSearch.self, from: data) {
                
                if searchresult.result.count > 0 {
                    joke = searchresult.result[0]
                }
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
