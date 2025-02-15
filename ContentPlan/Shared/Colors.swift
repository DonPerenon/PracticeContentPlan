//
//  Colors.swift
//  ContentPlan
//
//  Created by Виктор Иванов on 09.02.2025.
//

import SwiftUI

extension Color {
    static let primaryBackground = Color(UIColor.secondarySystemGroupedBackground)
    static let disableControlBackground = Color(UIColor.make(light: .gray.withAlphaComponent(0.3), dark: .darkGray))
    static let disableControlText = Color.white.opacity(0.6)
}


extension UIColor {

    static func make(light: UIColor, dark: UIColor) -> UIColor {
        UIColor.init { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? dark : light
        }
    }
}
