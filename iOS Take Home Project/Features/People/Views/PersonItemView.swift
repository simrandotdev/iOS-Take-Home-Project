//
//  PersonItemView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-13.
//

import SwiftUI

struct PersonItemView: View {
    
    let user: User
    
    var body: some View {
        VStack(spacing: .zero) {
            AsyncImage(url: URL(string: user.avatar)) { image in
                image
                    .resizable()
                    .frame(height: 130)
                    .scaledToFill()
            } placeholder: {
                ProgressView()
                
            }
            .frame(maxWidth: .infinity, minHeight: 130)
            .background(Theme.Colors.placeholder)
                
            
            VStack(alignment: .leading) {
                PillView(id: user.id)
                
                Text("\(user.firstName) \(user.lastName)")
                    .foregroundColor(Theme.Colors.text)
                    .font(Theme.Fonts.bodyRoundedBold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Theme.Colors.detailBackground)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 16,
                                    style: .continuous))
        .shadow(color: Theme.Colors.text.opacity(0.1),
                radius: 2,
                x: 0,
                y: 1)
    }
}

struct PersonItemView_Previews: PreviewProvider {
    static var previews: some View {
        PersonItemView(user: User(id: 1,
                                  email: "user@gmail.com",
                                  firstName: "John",
                                  lastName: "Doe",
                                  avatar: ""))
            .previewLayout(.sizeThatFits)
            
    }
}
