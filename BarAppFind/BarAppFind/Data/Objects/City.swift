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

class Bar: ObservableObject {
<<<<<<< HEAD
    
=======
    @StateObject var cloud = CloudKitCRUD()
>>>>>>> cloudKit
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
    func recieveAllReviews(){
        cloud.fetchItemsReview(barName: self.name)
        self.reviews = cloud.reviewListByBar
    }
    
}

struct Review {
    var writerEmail: String
    var writerName: String
    var grade: Double
    var description: String
    var barName: String
}
<<<<<<< HEAD

var cidade = City(name: "Porto Alegre")

class BarsMock: ObservableObject {
    
    var bar1 = Bar(name: "Maza", latitude: -30.06213, longitude: -51.174497)
    var bar2 = Bar(name: "Maza", latitude: -30.062134, longitude: -51.174497)
    var bar3 = Bar(name: "Maza", latitude: -30.0624, longitude: -51.174497)
    var bar4 = Bar(name: "Maza", latitude: -30.0134, longitude: -51.174497)
    var bar5 = Bar(name: "Maza", latitude: -30.034, longitude: -51.174497)
    var bar6 = Bar(name: "Maza", latitude: -30.2134, longitude: -51.174497)
    var bar7 = Bar(name: "Maza", latitude: -30.34, longitude: -51.174497)
    var bar8 = Bar(name: "Maza", latitude: -30.4, longitude: -51.174497)

    @Published var bares: [Bar] = []
    
    init() {
        self.bares = [bar1, bar2, bar3, bar4, bar5, bar6, bar7, bar8]
    }
    
}

var trendings: [String] = ["trending1", "trending2", "trending3"]
var moods: [String] = ["mood1", "mood2", "mood3", "mood4", "mood5", "mood6"]



=======
>>>>>>> cloudKit
