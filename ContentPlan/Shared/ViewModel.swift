//
//  ViewModel.swift
//
//  Created by Виктор Иванов on 09.02.2025.
//


import Combine

@MainActor
protocol ViewModel: ObservableObject {

    associatedtype State: Equatable
    associatedtype Action: Equatable

    var state: State { get set }

    func handle(action: Action)

}

class MockViewModel<State: Equatable, Action: Equatable>: ViewModel {

    var state: State

    init(state: State) {
        self.state = state
    }

    func handle(action _: Action) {}
}
