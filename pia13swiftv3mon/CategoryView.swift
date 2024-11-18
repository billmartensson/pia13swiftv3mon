//
//  CategoryView.swift
//  pia13swiftv3mon
//
//  Created by BillU on 2024-11-18.
//

import SwiftUI

struct CategoryView: View {
    
    var categoryname : String
    
    @State var joke : ChuckJoke?
    
    
    var body: some View {
        VStack {
            Text("CATEGORY")
            Text(categoryname)
            
            if let joke {
                Text(joke.id)
                Text(joke.value)
            }
            
        }
        .task {
            await loadjoke()
        }
    }
    
    
    func loadjoke() async {
        let jokeurl = URL(string: "https://api.chucknorris.io/jokes/random?category=\(categoryname)")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeurl)

            if let jokedata = try? JSONDecoder().decode(ChuckJoke.self, from: data) {
                
                joke = jokedata
            }
        } catch {
            print("Invalid data")
        }
    }
    
}

#Preview {
    CategoryView(categoryname: "animal")
}
