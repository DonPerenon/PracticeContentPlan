//
//  UseCases.swift
//  ContentPlan
//
//  Created by Виктор Иванов on 09.02.2025.
//

import Foundation

enum UseCase: String, Identifiable, Codable, CaseIterable {
    case newPost
    case newStories
}


extension UseCase {
    
    var id: String {
        rawValue
    }
    
    var title: String {
        switch self {
        case .newPost:
            "Post"
        case .newStories:
            "Stories"
        }
    }
    
    var imageName: String {
        switch self {
        case .newPost:
            "pencil.line"
        case .newStories:
            "newspaper.circle.fill"
        }
    }
}
