//
//  Theme.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-12.
//

import SwiftUI

enum Theme {
    
    enum Colors {
        static let background =  Color("background")
        static let detailBackground =  Color("detail-background")
        static let text =  Color("text")
        static let pill =  Color("pill")
        static let placeholder = Color.gray.opacity(0.25)
    }
    
    enum Fonts {
        static let captionRoundedBold = Font.system(.caption, design: .rounded).bold()
        static let headlineRoundedBold = Font.system(.headline, design: .rounded).bold()
        static let bodyRoundedBold = Font.system(.body, design: .rounded).bold()
        static let bodyRoundedSemiBold = Font.system(.body, design: .rounded).weight(.semibold)
        static let subHeadline = Font.system(.subheadline, design: .rounded)
            
    }
}

