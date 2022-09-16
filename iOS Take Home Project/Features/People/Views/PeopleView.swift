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
    @State private var showCreateView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(users, id: \.id) { user in
                            NavigationLink {
                                DetailView(user: user)
                            } label: {
                                PersonItemView(user: user)
                            }
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
                
                if users.count > 0 { return }
                
                NetworkingManager.shared.request("https://reqres.in/api/users?page=1&per_page=20",
                                                 type: UsersResponse.self) { result in
                    switch result {
                        
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.users += response.data
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            .sheet(isPresented: $showCreateView) {
                CreateView()
            }
        }
    }
}

private extension PeopleView {
    var create: some View {
        Button(action: {
            showCreateView = true
        }) {
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

