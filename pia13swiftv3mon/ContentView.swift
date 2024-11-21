//
//  ContentView.swift
//  pia13swiftv3mon
//
//  Created by BillU on 2024-11-18.
//

import SwiftUI

struct ContentView: View {
    
    @State var chuckapi = ChuckAPI()
    
    @State var searchtext = ""
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                VStack {
                    
                    HStack {
                        TextField("Search", text: $searchtext)
                        Button(action: {
                            Task {
                                await chuckapi.makesearch(searchtext: searchtext)
                            }
                        }) {
                            Text("Search")
                        }
                    }
                    
                    if chuckapi.joke != nil {
                        Text(chuckapi.joke!.id)
                        Text(chuckapi.joke!.value)
                            .frame(height: 200.0)
                    }
                    
                    Button(action: {
                        Task {
                            await chuckapi.loadjoke()
                        }
                    }) {
                        Text("Load random joke")
                    }
                    
                    
                    
                    List(chuckapi.jokecategories, id: \.self) { cat in
                        
                        NavigationLink(destination: CategoryView(categoryname: cat)) {
                            Text(cat)
                        }
                        
                    }
                    
                    
                    
                } // VStack
                .padding()
                
                
                if chuckapi.isLoading {
                    LoadingView()
                }
                
            } // ZSTACK
            .task {
                await chuckapi.loadjoke()
                await chuckapi.loadcategories()
            }
            
            
        } // nav stack
    } // body
    
    
}

#Preview {
    ContentView()
}
