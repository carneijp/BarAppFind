//
//  City.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 30/04/23.
//

import Foundation

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
    
    var name: String
    var description: String = ""
    var mood: String = ""
    var expensive: String = ""
    var grade: Double = 0.0
    var reviews: [Review] = []
    var operatinHours: [[String]] = [[]]
    var photos: [String] = []
    var latitude: Double
    var longitude: Double
    
    
    init(name: String, latitude: Double, longitude: Double){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    func changeDescription(description: String) {
        self.description = description
    }
    func addPhotos(photo: String) {
        self.photos.append(photo)
    }
    func removePhoto(photo: String) {
        for i in 0...photos.count {
            if photos[i] == photo{
                photos.remove(at: i)
            }
        }
    }
}

struct Review {
    var writer: User
    var grade: Double
    var description: String
    var bar: Bar
}

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



