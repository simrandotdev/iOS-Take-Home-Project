//
//  PillView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-13.
//

import SwiftUI

struct PillView: View {
    
    var id: Int
    
    var body: some View {
        Text("#\(id)")
            .font(Theme.Fonts.captionRoundedBold)
            .foregroundColor(.white)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(Theme.Colors.pill, in: Capsule())
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(id: 2)
    }
}
