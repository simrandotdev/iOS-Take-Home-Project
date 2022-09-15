//
//  DetailView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-14.
//

import SwiftUI

struct DetailView: View {
    
    var user: User
    
    @State private var userInfo: UserDetailResponse?
    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    
                    avatar
                    general
                    
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
                .padding()
            }
        }
        .navigationTitle(userInfo?.data.firstName ?? "Details")
        .onAppear {
            do {
                let res = try StaticJSONMapper.decode(file: "UserStaticData",
                                                      type: UsersResponse.self)
                guard let foundUser = res.data.first(where: { $0.id == user.id }) else { return }
                self.userInfo = UserDetailResponse(data: foundUser, support: res.support)
            } catch {
                // TODO: Handle any errors
                print("error")
            }
        }
    }
    
    private var general: some View {
        VStack(alignment: .leading, spacing: 8) {
            PillView(id: user.id)
            TitleSubtitleView(title: "First Name", subtitle: "\(userInfo?.data.firstName ?? "<First Name>")")
            Divider()
            TitleSubtitleView(title: "Last Name", subtitle: "\(userInfo?.data.lastName ?? "<Last Name>")")
            Divider()
            TitleSubtitleView(title: "Email", subtitle: "\(userInfo?.data.email ?? "<Email>")")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 18)
        .background(Theme.Colors.detailBackground,
                    in: RoundedRectangle(cornerRadius: 16,
                                         style: .continuous))
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarString = userInfo?.data.avatar,
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
