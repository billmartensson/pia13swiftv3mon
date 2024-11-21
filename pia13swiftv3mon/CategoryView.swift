//
//  CategoryView.swift
//  pia13swiftv3mon
//
//  Created by BillU on 2024-11-18.
//

import SwiftUI

struct CategoryView: View {
    
    var categoryname : String
    
    @StateObject var chuckapi = ChuckAPI()
    
    var body: some View {
        VStack {
            Text("CATEGORY")
            Text(categoryname)
            
            if chuckapi.joke != nil {
                Text(chuckapi.joke!.id)
                Text(chuckapi.joke!.value)
            }
            
        }
        .task {
            await chuckapi.loadjokeCategory(categoryname: categoryname)
        }
    }
    
    
    
    
}

#Preview {
    CategoryView(categoryname: "animal")
}
