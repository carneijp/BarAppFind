//
//  User.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//

import Foundation

class Clients: ObservableObject {
    var email: String
    var firstName: String
    var lastName: String
    var userID: String
    var password: String
    var badges: [String] = []
    var level: Int = 0
    var favorites: [String] = []
    
    init(email: String, firstName: String, password: String? = "", lastName: String, userID: String? = "") {
        self.email = email //chave unica
        self.firstName = firstName
        self.password = password ?? ""
        self.lastName = lastName
        self.userID = userID ?? ""
    }
}
