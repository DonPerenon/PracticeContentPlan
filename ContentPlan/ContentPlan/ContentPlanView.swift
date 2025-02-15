//
//  RootContentPlanView.swift
//  PlanmastaApp
//
//  Created by Виктор Иванов on 24.01.2025.
//

import SwiftUI

struct RootContentPlanView<VM: ViewModel>: View
    where VM.State == RootContentPlanState, VM.Action == RootContentPlanAction
{

    @ObservedObject private var viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel
    }

    var body: some View {
        let selectionBinding = Binding<TabSelection> (
            get: { viewModel.state.selectedTab },
            set: { viewModel.handle(action: .tabChanged($0)) }
        )
        TabView(selection: selectionBinding) {
            Text("Content").tag(TabSelection.main)
            .tabItem {
                tabButton(tab: .main)
            }
            
            workspaceView.tag(TabSelection.contentPlan)
            .tabItem {
                tabButton(tab: .contentPlan)
            }
           
            Text("Favorites").tag(TabSelection.favorites)
            .tabItem {
                tabButton(tab: .favorites)
            }
            
            Text("Profile").tag(TabSelection.profile)
            .tabItem {
                tabButton(tab: .profile)
            }
        }
        .onAppear {
            viewModel.handle(action: .firstAppear)
        }
    }
}

private extension RootContentPlanView {
    var workspaceView: some View {
        NavigationStack {
            filledPlanView
                .navigationTitle("Workspace")
        }
    }
    
    func tabButton(tab: TabSelection) -> some View {
        VStack {
            Button(action: { withAnimation { viewModel.state.selectedTab = tab } }) {
                VStack {
                    Image(source: tab.imageSource)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                    Text(tab.title)
                        .font(.caption)
                }
            }
            .foregroundStyle(viewModel.state.selectedTab == tab ? Color.accentColor : .secondary)
        }
    }
}

// MARK: - Filled

private extension RootContentPlanView {

    var filledPlanView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                weeklyPlanView

                Text("Daily plan")
                    .font(.title).fontWeight(.semibold)
                    .padding(5)

                dailyTipView

                dailyPlanView()
            }
            .padding()
        }
    }

    var weeklyPlanView: some View {
        VStack(alignment: .leading) {
            Text("Weekly plan")
                .bold()

            HStack {
                HStack(alignment: .center) {
                    Image(source: .bundle("instagram"))
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 16, maxHeight: 16)
                        .padding(.leading, 3)
                }

                Text("1 post, 1 story")
                    .font(.caption)
            }

            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    Image(source: .bundle("facebook"))
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 16, maxHeight: 16)
                        .padding(.leading, 3)
                }
                Text("1 post")
                    .font(.caption)
            }

            Button(action: { viewModel.handle(action: .buttonPressed) }, label: {
                HStack {
                    Text("Go to plan")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.black)
                .foregroundColor(.white) // сменить
                .fontWeight(.bold)
                .cornerRadius(10)

            })
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
        .background(Color(red: 225 / 255, green: 255 / 255, blue: 221 / 255))
        .foregroundStyle(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    var dailyTipView: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 5) {
                Image(source: .system("checkmark"))
                    .padding(.horizontal, 5)

                Text("Tip of the day")
                    .font(.title3).fontWeight(.semibold)

                Spacer()
            }
            .padding(.bottom, 5)

            Text("65% of Instagram users don’t pay attention to profile picture grid")
                .font(.subheadline)
        }
        .padding()
        .background(Color.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    func dailyPlanView() -> some View {
        VStack {
            if let dayPlanItem = viewModel.state.dayPlanItem {
                ForEach(dayPlanItem.contentItems, id: \.self) { contentItem in
                    contentItemView(contentItem: contentItem)
                }
            } else {
                Text("No plan available")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    @ViewBuilder
    func contentItemView(contentItem: ContentItem) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(source: contentItem.social.imageSource)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 16, maxHeight: 16)

                Text(contentItem.useCase.title)
                    .font(.body).bold()

                Spacer()

                if contentItem.isGenerated {
                    HStack {
                        Image(source: .system("checkmark"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color.accentColor)
                            .frame(maxWidth: 10)

                        Text("Generated")
                            .font(.caption)
                            .foregroundStyle(Color.accentColor)
                    }
                }
            }

            Text(contentItem.description)
                .font(.callout)
        }
        .padding(10)
        .background(Color.primaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(!contentItem.isGenerated ? Color.accentColor : Color.clear, lineWidth: 0.5)
        }
    }

}

// MARK: - Bindings

struct RootContentPlanState: Equatable {
    var selectedTab: TabSelection
    var dayPlanItem: DayPlanItem?
    var currentPlan: ContentPlan?
    var isButtonDisabled: Bool
}

extension RootContentPlanState {

    static var initial: Self {
        Self(
            selectedTab: .contentPlan,
            dayPlanItem: nil,
            currentPlan: nil,
            isButtonDisabled: true
        )
    }
}

enum RootContentPlanAction: Equatable {
    case firstAppear
    case tabChanged(TabSelection)
    case buttonPressed
}

#Preview {
    RootContentPlanView(viewModel: RootContentPlanViewModel())
}
