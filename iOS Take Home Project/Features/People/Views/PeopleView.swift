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
    @State private var shouldShowSuccess = false
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
                ToolbarItem(placement: .navigationBarLeading) {
                    refresh
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    create
                }
            }
            .onAppear {
                if viewModel.people.count > 0 { return }
                viewModel.fetchPeople()
            }
            .sheet(isPresented: $showCreateView) {
                CreateView {
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess = true
                    }
                }
            }
            .overlay {
                if shouldShowSuccess {
                    CheckmarkPopupView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                                withAnimation(.spring().delay(0.25)) {
                                    self.shouldShowSuccess = false
                                }
                            }
                        }
                }
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

