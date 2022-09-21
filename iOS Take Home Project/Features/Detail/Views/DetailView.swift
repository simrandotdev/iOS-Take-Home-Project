//
//  DetailView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-14.
//

import SwiftUI

struct DetailView: View {
    
    var user: User

    @StateObject private var viewModel = DetailView.ViewModel()
    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    
                    switch viewModel.viewState {
                    case .loading:
                        ProgressView()
                    case .success:
                        avatar
                        userDetails
                        support
                    case .error(_):
                        Text("Something went wrong!")
                    case .empty:
                        EmptyView()
                    }
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.user?.firstName ?? "Details")
        .onAppear {
            Task { await viewModel.fetchDetails(withId: user.id) }
        }
    }
    
    private var userDetails: some View {
        VStack(alignment: .leading, spacing: 8) {
            PillView(id: user.id)
            TitleSubtitleView(title: "First Name", subtitle: "\(viewModel.user?.firstName ?? "<First Name>")")
            Divider()
            TitleSubtitleView(title: "Last Name", subtitle: "\(viewModel.user?.lastName ?? "<Last Name>")")
            Divider()
            TitleSubtitleView(title: "Email", subtitle: "\(viewModel.user?.email ?? "<Email>")")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 18)
        .background(Theme.Colors.detailBackground,
                    in: RoundedRectangle(cornerRadius: 16,
                                         style: .continuous))
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarString = viewModel.user?.avatar,
            let avatarUrl = URL(string: avatarString) {
            AsyncImage(url: avatarUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity, minHeight: 250)
            .background(Theme.Colors.placeholder)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    private var support: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            TitleSubtitleView(title: "Support Reqres", subtitle: "")
            Link(destination: URL(string: "https://reqres.in/#support-heading")!) {
                Label("https://reqres.in/#support-heading", systemImage: "link")
            }
            Divider().hidden()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 18)
        .background(Theme.Colors.detailBackground,
                    in: RoundedRectangle(cornerRadius: 16,
                                         style: .continuous))
    }
    
    var background: some View {
        Theme.Colors.background
            .ignoresSafeArea(edges: .top)
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(user: User(id: 1,
                                  email: "user@gmail.com",
                                  firstName: "John",
                                  lastName: "Doe",
                                  avatar: "https://reqres.in/img/faces/1-image.jpg"))
        }
    }
}
