//
//  ImageExtension.swift
//  ContentPlan
//
//  Created by Виктор Иванов on 09.02.2025.
//

import SwiftUI

enum ImageSource: Hashable {
    case system(String)
    case bundle(String)
}

extension Image {
    init(source: ImageSource) {
        self = switch source {
        case let .system(string):
            Image(systemName: string)
        case let .bundle(string):
            Image(string)
        }
    }
}
