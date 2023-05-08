//
//  BarAppFindApp.swift
//  BarAppFind
//
//  Created by Joao Paulo Carneiro on 28/04/23.
//

import SwiftUI

@main
struct BarAppFindApp: App {
    @StateObject var cloud = CloudKitCRUD()
    var body: some Scene {
        WindowGroup {
            GeneralTab()
                .environmentObject(cloud)
        }
    }
}
