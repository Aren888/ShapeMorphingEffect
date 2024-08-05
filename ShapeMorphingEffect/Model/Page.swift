//
//  Page.swift
//  ShapeMorphingEffect
//
//  Created by Solicy Ios on 30.07.24.
//

import Foundation

enum Page: String, CaseIterable {
    
    case page1 = "playstation.logo"
    case page2 = "gamecontroller.fill"
    case page3 = "link.icloud.fill"
    case page4 = "text.bubble.fill"
    
    var title: String {
        switch self {
        case .page1: return "Welcome to PlayStation®"
        case .page2: return "DualSense® Wireless Controller"
        case .page3: return "PlayStation® Remote Play"
        case .page4: return "Connect with People"
        }
    }
    
    var subTitle: String {
        switch self {
        case .page1: return "Start here"
        case .page2: return "Enhanced gameplay"
        case .page3: return "Stream seamlessly"
        case .page4: return "Make connections"
        }
    }
    
    var description: String {
        switch self {
        case .page1:
            return "Discover PlayStation® features."
        case .page2:
            return "Advanced DualSense® features."
        case .page3:
            return "Stream PS5™ to Apple."
        case .page4:
            return "Expand your network."
        }
    }
    
    var index: CGFloat {
        switch self {
        case .page1: return 0
        case .page2: return 1
        case .page3: return 2
        case .page4: return 3
        }
    }
    
    /// Fetches the next page, if it's not the last page
    var nextPage: Page {
        let index = Int(self.index) + 1
        if index < 4 {
            return Page.allCases[index]
        }
        return self
    }
    
    /// Fetches the previous page, if it's not the first page
    var previousPage: Page {
        let index = Int(self.index) - 1
        if index >= 0 {
            return Page.allCases[index]
        }
        return self
    }
}
