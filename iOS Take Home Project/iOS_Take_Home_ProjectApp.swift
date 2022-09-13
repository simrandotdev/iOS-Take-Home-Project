//
//  iOS_Take_Home_ProjectApp.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-12.
//

import SwiftUI

@main
struct iOS_Take_Home_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PeopleView()
                    .tabItem {
                        Symbols.person
                        Text("Home")
                    }
            }
        }
    }
}
