//
//  HapticsManager.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-20.
//

import Foundation
import UIKit

fileprivate final class HapticsManager {
    
    private init() {}
    
    static let shared = HapticsManager()
    
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedbackGenerator.notificationOccurred(notification)
    }
}


func triggerHaptics(_ notification: UINotificationFeedbackGenerator.FeedbackType = .success) {
    HapticsManager.shared.trigger(notification)
}
