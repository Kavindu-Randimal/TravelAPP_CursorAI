import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var error: Error?
    @Published var isEditing = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUserProfile() {
        isLoading = true
        
        // TODO: Implement actual API calls
        // For now, we'll use mock data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.user = self?.mockUser()
            self?.isLoading = false
        }
    }
    
    func updateUserProfile(name: String, email: String, preferences: UserPreferences) {
        guard var user = user else { return }
        
        user.name = name
        user.email = email
        user.preferences = preferences
        
        // TODO: Implement actual API call to update user
        self.user = User(
            id: user.id,
            email: user.email,
            name: user.name,
            profileImage: user.profileImage,
            preferences: user.preferences,
            savedTrips: user.savedTrips,
            favoritePlaces: user.favoritePlaces
        )
    }
    
    // MARK: - Mock Data
    private func mockUser() -> User {
        return User(
            id: "1",
            email: "user@example.com",
            name: "John Doe",
            profileImage: nil,
            preferences: UserPreferences(
                language: "English",
                currency: "USD",
                notificationsEnabled: true
            ),
            savedTrips: [],
            favoritePlaces: []
        )
    }
} 
