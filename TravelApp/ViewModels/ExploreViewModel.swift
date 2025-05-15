import Foundation
import CoreLocation
import Combine

class ExploreViewModel: ObservableObject {
    @Published var nearbyPlaces: [Place] = []
    @Published var selectedCategory: Place.PlaceType?
    @Published var searchQuery = ""
    @Published var isLoading = false
    @Published var error: Error?
    @Published var userLocation: CLLocationCoordinate2D?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        // TODO: Implement location manager
        // For now, we'll use a mock location
        userLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    }
    
    func fetchNearbyPlaces() {
        isLoading = true
        
        // TODO: Implement actual API calls
        // For now, we'll use mock data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.nearbyPlaces = self?.mockPlaces() ?? []
            self?.isLoading = false
        }
    }
    
    func filterPlaces() -> [Place] {
        var filtered = nearbyPlaces
        
        if let category = selectedCategory {
            filtered = filtered.filter { $0.type == category }
        }
        
        if !searchQuery.isEmpty {
            filtered = filtered.filter {
                $0.name.localizedCaseInsensitiveContains(searchQuery) ||
                $0.description.localizedCaseInsensitiveContains(searchQuery)
            }
        }
        
        return filtered
    }
    
    // MARK: - Mock Data
    private func mockPlaces() -> [Place] {
        // Return mock places
        return []
    }
} 