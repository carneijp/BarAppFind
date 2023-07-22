//
//  TabBarItem.swift
//  Onde
//
//  Created by Guilherme Borges Cavali on 09/07/23.
//

import SwiftUI
import Foundation

enum TabBarItems: CaseIterable, Hashable {
    case menu, map, favorites, profile
    
    var tag: Int {
        switch self {
        case .menu:
            return 0
        case .map:
            return 1
        case .favorites:
            return 2
        case .profile:
            return 3
        }
    }
    
    var tabName: String {
        switch self {
        case .menu:
            return "Menu"
        case .map:
            return "Mapa"
        case .favorites:
            return "Favoritos"
        case .profile:
            return "Perfil"
        }
    }
    
    var iconName: String {
        switch self {
        case .menu:
            return "house"
        case .map:
            return "map.fill"
        case .favorites:
            return "heart"
        case .profile:
            return "person.fill"
        }
    }
}

