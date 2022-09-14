//
//  PeopleView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-13.
//

import SwiftUI

struct PeopleView: View {
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(users, id: \.id) { user in
                            PersonItemView(user: user)
                        }
                    }
                    .padding(6)
                }
                    
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear {
                do {
                    let res = try StaticJSONMapper.decode(file: "UserStaticData",
                                                          type: UsersResponse.self)
                    self.users = res.data
                } catch {
                    // TODO: Handle any errors
                    print("error")
                }
            }
        }
    }
}

private extension PeopleView {
    var create: some View {
        Button(action: {}) {
            Symbols.plus
                .font(Theme.Fonts.headlineRoundedBold)
        }
    }
    
    var background: some View {
        Theme.Colors.background
            .ignoresSafeArea(edges: .top)
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            PeopleView()
                .tabItem {
                    Symbols.person
                    Text("Home")
                }
        }
    }
}

