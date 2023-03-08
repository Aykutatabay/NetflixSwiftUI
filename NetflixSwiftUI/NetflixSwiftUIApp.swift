//
//  NetflixSwiftUIApp.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 5.02.2023.
//

import SwiftUI

@main
struct NetflixSwiftUIApp: App {
    @StateObject var homeVM = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            
            ContentView()
                .environmentObject(homeVM)
        }
    }
}
