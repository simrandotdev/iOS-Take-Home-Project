//
//  PersonItemView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-13.
//

import SwiftUI

struct PersonItemView: View {
    
    let user: Int
    
    var body: some View {
        VStack(spacing: .zero) {
            Rectangle()
                .fill(.blue)
                .frame(height: 130)
            
            VStack(alignment: .leading) {
                PillView(id: user)
                
                Text("<First Name> <Last Name>")
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
        PersonItemView(user: 1)
            .previewLayout(.sizeThatFits)
            
    }
}
