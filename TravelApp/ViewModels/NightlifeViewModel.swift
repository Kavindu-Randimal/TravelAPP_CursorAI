import Foundation
import Combine
import CoreLocation
import SwiftUI

class NightlifeViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var venues: [Place] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var selectedDate = Date()
    @Published var selectedCategory: EventCategory?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchEvents() {
        isLoading = true
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.events = self.getSampleEvents()
            self.isLoading = false
        }
    }
    
    func filterEvents() -> [Event] {
        var filteredEvents = events
        
        // Filter by date
        let calendar = Calendar.current
        filteredEvents = filteredEvents.filter { event in
            calendar.isDate(event.date, inSameDayAs: self.selectedDate)
        }
        
        // Filter by category if selected
        if let category = selectedCategory {
            filteredEvents = filteredEvents.filter { event in
                // Add category property to Event model if needed
                true // Placeholder
            }
        }
        
        return filteredEvents
    }
    
    // MARK: - Mock Data
    private func mockEvents() -> [Event] {
        // Return mock events
        return []
    }
    
    private func mockVenues() -> [Place] {
        // Return mock venues
        return []
    }
    
    private func getSampleEvents() -> [Event] {
        let venue = Venue(name: "Stockholm Arena", address: "123 Main St, Stockholm")
        
        return [
            Event(
                name: "Summer Music Festival",
                description: "Join us for the biggest music festival of the summer!",
                date: Date(),
                startTime: Date(),
                endTime: Date().addingTimeInterval(3600 * 4),
                price: 99.99,
                ticketAvailability: 50,
                images: ["event1"],
                venue: venue,
                performers: ["DJ Smith", "Live Band"],
                category: .music
            ),
            Event(
                name: "Beach Party",
                description: "Dance the night away at our beach party!",
                date: Date().addingTimeInterval(86400),
                startTime: Date().addingTimeInterval(86400),
                endTime: Date().addingTimeInterval(86400 + 3600 * 6),
                price: 49.99,
                ticketAvailability: 100,
                images: ["event2"],
                venue: venue,
                performers: ["DJ Johnson", "Live DJ Set"],
                category: .music
            )
        ]
    }
} 
