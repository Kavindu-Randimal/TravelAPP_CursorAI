import Foundation
import Combine

class TripsViewModel: ObservableObject {
    @Published var trips: [Trip] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var selectedTripStatus: Trip.TripStatus?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTrips() {
        isLoading = true
        
        // TODO: Implement actual API calls
        // For now, we'll use mock data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.trips = self?.mockTrips() ?? []
            self?.isLoading = false
        }
    }
    
    func filterTrips() -> [Trip] {
        guard let status = selectedTripStatus else {
            return trips
        }
        return trips.filter { $0.status == status }
    }
    
    func createNewTrip(name: String, destination: String, startDate: Date, endDate: Date, budget: Double) {
        let newTrip = Trip(
            id: UUID().uuidString,
            name: name,
            startDate: startDate,
            endDate: endDate,
            destination: destination,
            budget: budget,
            accommodations: [],
            activities: [],
            transportation: [],
            status: .planning
        )
        
        trips.append(newTrip)
        // TODO: Save to backend
    }
    
    // MARK: - Mock Data
    private func mockTrips() -> [Trip] {
        // Return mock trips
        return []
    }
} 