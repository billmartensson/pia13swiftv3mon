//
//  LoadingView.swift
//  pia13swiftv3mon
//
//  Created by BillU on 2024-11-21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
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
            .frame(width: 250.0, height: 250.0)
            .background(Color("FancyRed"))
        }
    }
}

#Preview {
    LoadingView()
}
