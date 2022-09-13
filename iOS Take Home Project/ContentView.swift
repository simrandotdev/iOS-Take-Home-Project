//
//  ContentView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                print("👇🏽 Users Response")
                dump(try? StaticJSONMapper.decode(file: "UserStaticData",
                                             type: UsersResponse.self))
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
