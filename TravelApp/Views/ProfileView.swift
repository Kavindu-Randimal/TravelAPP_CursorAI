import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showingEditProfile = false
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if let user = viewModel.user {
                    ScrollView {
                        VStack(spacing: 20) {
                            ProfileHeader(user: user)
                            PreferencesSection(preferences: user.preferences)
                            SavedTripsSection(trips: user.savedTrips)
                            FavoritePlacesSection(places: user.favoritePlaces)
                        }
                        .padding(.vertical)
                    }
                } else {
                    Text("Failed to load profile")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        showingEditProfile = true
                    }
                }
            }
            .sheet(isPresented: $showingEditProfile) {
                if let user = viewModel.user {
                    EditProfileView(viewModel: viewModel, user: user)
                }
            }
        }
        .onAppear {
            viewModel.fetchUserProfile()
        }
    }
}

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    let user: User
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var email: String
    @State private var language: String
    @State private var currency: String
    @State private var notificationsEnabled: Bool
    
    init(viewModel: ProfileViewModel, user: User) {
        self.viewModel = viewModel
        self.user = user
        _name = State(initialValue: user.name)
        _email = State(initialValue: user.email)
        _language = State(initialValue: user.preferences.language)
        _currency = State(initialValue: user.preferences.currency)
        _notificationsEnabled = State(initialValue: user.preferences.notificationsEnabled)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                }
                
                Section(header: Text("Preferences")) {
                    TextField("Language", text: $language)
                    TextField("Currency", text: $currency)
                    Toggle("Notifications", isOn: $notificationsEnabled)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    saveChanges()
                }
            )
        }
    }
    
    private func saveChanges() {
        let updatedUser = User(
            id: user.id,
            email: email,
            name: name,
            profileImage: user.profileImage,
            preferences: UserPreferences(
                language: language,
                currency: currency,
                notificationsEnabled: notificationsEnabled
            ),
            savedTrips: user.savedTrips,
            favoritePlaces: user.favoritePlaces
        )
        
        viewModel.updateUserProfile(
            name: updatedUser.name,
            email: updatedUser.email,
            preferences: updatedUser.preferences
        )
        dismiss()
    }
} 
