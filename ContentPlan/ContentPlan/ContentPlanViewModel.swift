//
//  ContentPlanViewModel.swift
//  PlanmastaApp
//
//  Created by Виктор Иванов on 24.01.2025.
//
import Foundation

@MainActor
class RootContentPlanViewModel: ViewModel {
    // MARK: Public Properties
    
    @Published var state: RootContentPlanState
    private var currentPlan: ContentPlan?
    
    // MARK: Lifecycle
    
    init(
        state: RootContentPlanState = .initial
    ) {
        self.state = state
    }
    
    // MARK: Public methods
    
    func handle(action: RootContentPlanAction) {
        switch action {
        case .firstAppear:
            let currentDate = generate7Days()[2]
            let dates = generate7Days()
            currentPlan = ContentPlan(
                startDate: dates[0], 
                socials: [.facebook, .instagram],
                audiences: ["Sportlovers, Men"],
                language: "English",
                dayPlanItems: [
                    DayPlanItem(
                        date: dates[0],
                        contentItems: [
                            ContentItem(social: .facebook, useCase: .newPost, description: MockContentItemDescriptions.facebookPost, isGenerated: false),
                        ],
                        description: "Equipment-free training"
                    ),
                    DayPlanItem(date: dates[1], contentItems: [
                        ContentItem(social: .facebook, useCase: .newPost, description: MockContentItemDescriptions.facebookPost, isGenerated: false),
                    ],
                                description: "Equipment-free training"),
                    DayPlanItem(date: dates[2], contentItems: [
                        ContentItem(social: .facebook, useCase: .newPost, description: MockContentItemDescriptions.facebookPost, isGenerated: false),
                        ContentItem(social: .instagram, useCase: .newStories, description: MockContentItemDescriptions.instagramStory, isGenerated: true),
                        ContentItem(social: .facebook, useCase: .newPost, description: MockContentItemDescriptions.facebookPost, isGenerated: false),
                    ],
                                description: "Equipment-free training"),
                    DayPlanItem(date: dates[3], contentItems: [
                        ContentItem(social: .facebook, useCase: .newPost, description: MockContentItemDescriptions.facebookPost, isGenerated: false),
                    ],
                                description: "Equipment-free training"),
                    DayPlanItem(date: dates[4], contentItems: [
                        ContentItem(social: .facebook, useCase: .newPost, description: MockContentItemDescriptions.facebookPost, isGenerated: false),
                    ],
                                description: "Equipment-free training"),
                    DayPlanItem(date: dates[5], contentItems: [
                        ContentItem(social: .facebook, useCase: .newPost, description: MockContentItemDescriptions.facebookPost, isGenerated: false),
                    ],
                                description: "Equipment-free training"),
                    DayPlanItem(date: dates[6], contentItems: [
                        ContentItem(social: .facebook, useCase: .newPost, description: MockContentItemDescriptions.facebookPost, isGenerated: false),
                    ],
                                description: "Equipment-free training"),
                ]
            )
            state.dayPlanItem = dayPlanItemForToday()
            
        case .buttonPressed:
            break
            
        case let .tabChanged(tab):
            state.selectedTab = tab
        }
        
        // MARK: Private methods
        
        func generate7Days() -> [Date] {
            var dates = [Date]()
            let calendar = Calendar.current
            let today = Date()
            
            for offset in 0 ..< 7 {
                if let newDate = calendar.date(byAdding: .day, value: offset, to: today) {
                    dates.append(newDate)
                }
            }
            
            return dates
        }
        
        func dayPlanItemForToday() -> DayPlanItem? {
            guard let plan = currentPlan else {
                return nil
            }
            
            let dayPlanItems = plan.dayPlanItems
            
            if let todayPlanItem = dayPlanItems.first(where: {
                Calendar.current.isDate($0.date, inSameDayAs: Date())
            }) {
                return todayPlanItem
            } else {
                return nil
            }
        }
        
        enum MockContentItemDescriptions {
            
            static let facebookPost = """
        Carousel — "Top 5 Fitness Tips for Better Performance"
        Slide 1: Warm-up routines and their importance
        Slide 2: Setting realistic fitness goals
        Slide 3: Tips for improving endurance and strength
        Slide 4: Importance of recovery and rest days
        Slide 5: Brief exercise suggestions (HIIT, strength training, yoga)
        """
            
            static let instagramStory = """
        Poll — "What’s your favorite type of workout?"
        Options: Cardio / Strength Training / Yoga / Mixed Martial Arts
        """
        }
    }
}

// Model

struct ContentPlan: Equatable {
    let startDate: Date
    let socials: [Socials] // можно достать из dayPlanItems
    let audiences: [String]
    let language: String
    let dayPlanItems: [DayPlanItem]
}

struct DayPlanItem: Equatable, Hashable {
    let date: Date
    let contentItems: [ContentItem]
    let description: String
}

struct ContentItem: Equatable, Hashable {
    let social: Socials
    let useCase: UseCase // проверять .contain(social)
    let description: String
    var isGenerated: Bool
}

enum TabSelection: Equatable {
    case main
    case favorites
    case profile
    case contentPlan

    var title: String {
        switch self {
        case .main:
            return "Content"
        case .favorites:
            return "Favorites"
        case .profile:
            return "Profile"
        case .contentPlan:
            return "Plan"
        }
    }

    var imageSource: ImageSource {
        switch self {
        case .main:
            .system("square.grid.2x2")
        case .favorites:
            .system("bookmark.fill")
        case .profile:
            .system("person.fill")
        case .contentPlan:
            .system("calendar")
        }
    }
}
