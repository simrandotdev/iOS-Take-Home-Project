//
//  DetailView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-14.
//

import SwiftUI

struct DetailView: View {
    
    var user: User
    
    var body: some View {
        ZStack {
            Theme.Colors.background.background(ignoresSafeAreaEdges: .top)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
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
    }
    
    private var general: some View {
        VStack(alignment: .leading, spacing: 8) {
            PillView(id: user.id)
            
            TitleSubtitleView(title: "First Name", subtitle: "\(user.firstName)")
            Divider()
            TitleSubtitleView(title: "Last Name", subtitle: "\(user.lastName)")
            Divider()
            TitleSubtitleView(title: "Email", subtitle: "\(user.email)")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 18)
        .background(Theme.Colors.detailBackground,
                    in: RoundedRectangle(cornerRadius: 16,
                                         style: .continuous))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: User(id: 1,
                              email: "user@gmail.com",
                              firstName: "John",
                              lastName: "Doe",
                              avatar: ""))
    }
}
