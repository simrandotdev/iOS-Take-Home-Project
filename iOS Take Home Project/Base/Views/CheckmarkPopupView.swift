//
//  CheckmarkPopupView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-20.
//

import SwiftUI

struct CheckmarkPopupView: View {
    var body: some View {
        Symbols.checkmark
            .font(Theme.Fonts.largeTitleRoundedBold)
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CheckmarkPopupView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkPopupView()
    }
}
