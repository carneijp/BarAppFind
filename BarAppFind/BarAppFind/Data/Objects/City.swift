//
//  City.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//

import Foundation
import SwiftUI

class City: ObservableObject {
    var name: String
    @Published var bars: [Bar] = []
    init(name:String) {
        self.name = name
    }
    func addBar(bar: Bar){
        bars.append(bar)
    }
}

class Bar: ObservableObject, Hashable, Identifiable {
    static func == (lhs: Bar, rhs: Bar) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
    
    @StateObject var cloud = CloudKitCRUD()
    var name: String
    var description: String
    var caracteristicas: [String]
    var mood: [String]
    var expensive: String = ""
    var grade: Double
    var reviews: [Review] = []
    var operatinHours: [String]
    var photosTOSave: [String] = []
    var photosLogo: URL? = nil
    var photoLogoTOSave: String = ""
    var photosToUse: [URL?] = []
    var latitude: Double
    var longitude: Double
    var endereco: String
    var regiao: String
    
    
    init(name: String, description: String, mood: [String], grade: Double, latitude: Double, longitude: Double, operatinhours: [String], endereco: String, regiao: String, caracteristicas: [String]) {
        self.name = name
        self.description = description
        self.caracteristicas = caracteristicas
        self.mood = mood
        self.grade = grade
        self.operatinHours = operatinhours
        self.latitude = latitude
        self.longitude = longitude
        self.endereco = endereco
        self.regiao = regiao
    }
    func recieveLogoPhoto(logo: URL){
        self.photosLogo = logo
    }
    func recieveAllPhotos(photosToSAVE:[String]){
        self.photosTOSave = photosToSAVE
    }
    func recieveAllPhotos(photosToUSE:[URL]){
        self.photosToUse = photosToUSE
    }
//    func recieveAllReviews(){
//        cloud.fetchItemsReview(barName: self.name){
//            self.reviews = self.cloud.reviewListByBar
//        }
//        
//    }
    
}

class Review: ObservableObject, Hashable, Identifiable {
    
    
    var writerEmail: String
    var writerName: String
    var grade: Double
    var description: String
    var barName: String
    
    init(writerEmail: String, writerName: String, grade: Double, description: String, barName: String) {
        self.writerEmail = writerEmail
        self.writerName = writerName
        self.grade = grade
        self.description = description
        self.barName = barName
    }
    
    static func == (lhs: Review, rhs: Review) -> Bool {
        lhs.writerName == rhs.writerName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(writerEmail)
        hasher.combine(barName)
    }
}

var trendings: [String] = ["Bibah","Brita","Quentins"]
var moods: [String] = ["mood1","mood2","mood3","mood4","mood5","mood6"]
