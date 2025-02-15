//
//  Socials.swift
//  ContentPlan
//
//  Created by Виктор Иванов on 09.02.2025.
//

enum Socials: DropDownItemRespresentable {
    case instagram
    case facebook

    var title: String {
        switch self {
        case .instagram:
            "Instagram"
        case .facebook:
            "Facebook"
        }
    }

    var imageSource: ImageSource {
        switch self {
        case .instagram:
            .bundle("instagram")
        case .facebook:
            .bundle("facebook")
        }
    }
}

protocol DropDownItemRespresentable: Hashable, CaseIterable {
    var title: String { get }
    var imageSource: ImageSource { get }
}
