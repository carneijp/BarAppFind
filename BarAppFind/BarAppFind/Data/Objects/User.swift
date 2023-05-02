//
//  User.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//

import Foundation

class User: ObservableObject {
    var name: String
    var login: String
    private var password: String
//    var birthday: Date = Date.now
    init(name: String, login: String, password: String){
        self.name = name
        self.login = login
        self.password = password
    }
}
