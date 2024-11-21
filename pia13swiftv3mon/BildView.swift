//
//  BildView.swift
//  pia13swiftv3mon
//
//  Created by BillU on 2024-11-21.
//

import SwiftUI

struct BildView: View {
    var body: some View {
        VStack {
            Image("frog")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300.0, height: 100.0)
                .background(Color.red)
                .border(Color.pink)
                .clipped()
            
            
            Image("frog")
                .resizable()
                .frame(width: 300, height: 300)
                .scaledToFill()
                .clipShape(.circle)
                .clipped()
                .accessibilityLabel("groda")
            
            VStack {
                
            }
            .frame(width: 40, height: 40)
            .background(Color("FancyRed"))
            
        }
    }
}

#Preview {
    BildView().preferredColorScheme(.light)
}
#Preview {
    BildView().preferredColorScheme(.dark)
}
