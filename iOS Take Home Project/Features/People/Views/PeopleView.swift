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
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.Colors.background
                    .ignoresSafeArea(edges: .top)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0...15, id: \.self) { item in
                            
                            VStack(spacing: .zero) {
                                Rectangle()
                                    .fill(.blue)
                                    .frame(height: 130)
                                
                                VStack(alignment: .leading) {
                                    Text("#\(item)")
                                        .font(Theme.Fonts.captionRoundedBold)
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 9)
                                        .padding(.vertical, 4)
                                        .background(Theme.Colors.pill, in: Capsule())
                                    
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
                    .padding(6)
                }
                    
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Symbols.plus
                        .font(Theme.Fonts.headlineRoundedBold)
                }
            }
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
