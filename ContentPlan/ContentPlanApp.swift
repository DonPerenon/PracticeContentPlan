//
//  ContentPlanApp.swift
//  ContentPlan
//
//  Created by Виктор Иванов on 09.02.2025.
//

import SwiftUI

@main
struct ContentPlanApp: App {
    var body: some Scene {
        WindowGroup {
            RootContentPlanView(viewModel: RootContentPlanViewModel())
        }
    }
}
