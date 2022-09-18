//
//  ViewState.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-18.
//


// TODO: Create different view states for the UI.
import Foundation

enum ViewState {
    case loading
    case success
    case error(error: Error)
    case empty
}
