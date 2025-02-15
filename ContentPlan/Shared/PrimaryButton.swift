//
//  PrimaryButton.swift
//  ContentPlan
//
//  Created by Виктор Иванов on 09.02.2025.
//

import SwiftUI

struct PrimaryButton: View {

    enum Style {
        case primary, secondary, destractive
    }

    private let text: String
    private var imageSource: ImageSource?
    private let action: () -> Void
    private var isDisabled: Bool = false
    private let style: Style

    init(
        _ text: String,
        style: Style = .primary,
        imageSource: ImageSource? = nil,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.style = style
        self.imageSource = imageSource
        self.action = action
    }

    var body: some View {
        Button(action: action, label: {
            HStack {
                Text(text)

                if let imageSource = imageSource {
                    Image(source: imageSource)
                        .resizable()
                        .foregroundStyle(textForegroundColor)
                        .frame(width: 25, height: 16.5)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 50)
            .background(textBackgroundColor.overlay(Color.accentColor.opacity(0.1)))
            .foregroundColor(textForegroundColor)
            .fontWeight(.bold)
            .cornerRadius(10)

        })
        .buttonStyle(BorderlessButtonStyle())
        .disabled(isDisabled)
    }

    func disabled(_ isDisabled: Bool) -> Self {
        var button = self
        button.isDisabled = isDisabled

        return button
    }

    private var textBackgroundColor: Color {
        switch style {
        case .primary:
            isDisabled ? Color.disableControlBackground : Color.accentColor

        case .secondary:
            isDisabled ? Color.disableControlBackground : Color.secondaryBackground

        case .destractive:
            isDisabled ? Color.disableControlBackground : Color.red.opacity(0.8)
        }
    }

    private var textForegroundColor: Color {
        switch style {
        case .primary, .destractive:
            isDisabled ? Color.disableControlText : Color.white

        case .secondary:
            isDisabled ? Color.disableControlBackground : Color.accentColor
        }
    }
}
