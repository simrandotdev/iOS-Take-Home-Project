//
//  TitleSubtitleView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-14.
//

import SwiftUI

struct TitleSubtitleView: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if !title.isEmpty {
                Text(title)
                    .font(Theme.Fonts.bodyRoundedSemiBold)
            }
            
            if !subtitle.isEmpty {
                Text(subtitle)
                    .foregroundColor(Theme.Colors.text)
                    .font(Theme.Fonts.subHeadline)
            }
        }
        .foregroundColor(Theme.Colors.text)
    }
}

struct TitleSubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleSubtitleView(title: "First Name", subtitle: "John")
    }
}
