//
//  ChuckModel.swift
//  pia13swiftv3mon
//
//  Created by BillU on 2024-11-21.
//

import Foundation

struct ChuckJoke : Codable {
    var id : String
    var url : String
    var value : String
}

struct ChuckSearch : Codable {
    var total : Int
    let result : [ChuckJoke]
}
