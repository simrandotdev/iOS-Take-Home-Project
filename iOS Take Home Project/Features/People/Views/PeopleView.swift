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
    
    @State private var showCreateView = false
    @StateObject private var viewModel = PeopleView.ViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                case .success:
                    peopleList
                case .error(_):
                    Text("Something went wrong!")
                case .empty:
                    EmptyView()
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    refresh
                }
                
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear {
                if viewModel.people.count > 0 { return }
                viewModel.fetchPeople()
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
    
    var refresh: some View {
        Button(action: {
            viewModel.fetchPeople()
        }) {
            Symbols.refresh
                .font(Theme.Fonts.headlineRoundedBold)
        }
    }
    
    var background: some View {
        Theme.Colors.background
            .ignoresSafeArea(edges: .top)
    }
    
    var peopleList: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.people, id: \.id) { user in
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

