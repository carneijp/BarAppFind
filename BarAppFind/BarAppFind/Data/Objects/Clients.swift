//
//  User.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//

import Foundation

class Clients: ObservableObject {
    var email: String
    var nickName: String
    var name: String
    var phone: String
    var cpf: String
    var gender: String
    var password: String
//    var photoTosave: String = ""
//    var photoToUse: [URL?] = []
//    var photo: 
    
    init(email: String, name: String, phone: String, cpf: String, gender: String, password: String, nickName: String) {
        self.email = email
        self.name = name
        self.phone = phone
        self.cpf = cpf
        self.gender = gender
        self.password = password
        self.nickName = nickName
    }
}
