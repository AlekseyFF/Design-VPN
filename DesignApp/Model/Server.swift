//
//  Server.swift
//  DesignApp
//
//  Created by Aleksey Fedorov on 21.12.2021.
//

import SwiftUI

struct Server: Identifiable {
    
    var id = UUID()
    var name: String
    var flag: String
}

var servers = [
    Server(name: "USA", flag: "USA"),
    Server(name: "Canada", flag: "Canada"),
    Server(name: "Germany", flag: "Germany"),
    Server(name: "Italy", flag: "Italy"),
    Server(name: "Spain", flag: "Spain"),
    Server(name: "France", flag: "France")
]
