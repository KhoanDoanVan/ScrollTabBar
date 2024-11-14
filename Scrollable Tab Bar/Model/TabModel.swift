//
//  TabModel.swift
//  Scrollable Tab Bar
//
//  Created by Đoàn Văn Khoan on 14/11/24.
//


import SwiftUI

struct TabModel: Identifiable {
    private(set) var id: Tab
    var size: CGSize = .zero
    var minX: CGFloat = .zero
    
    enum Tab: String, CaseIterable {
        case research = "Research"
        case deployment = "Development"
        case analytics = "Analytics"
        case audience = "Audience"
        case privacy = "Privacy"
    }
}
