import SwiftUI

struct PreferencesSection: View {
    let preferences: UserPreferences
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Preferences")
                .font(.headline)
                .padding(.horizontal)
            
            VStack(spacing: 0) {
                PreferenceRow(
                    icon: "globe",
                    title: "Language",
                    value: preferences.language
                )
                
                Divider()
                
                PreferenceRow(
                    icon: "dollarsign.circle",
                    title: "Currency",
                    value: preferences.currency
                )
                
                Divider()
                
                PreferenceRow(
                    icon: "bell",
                    title: "Notifications",
                    value: preferences.notificationsEnabled ? "Enabled" : "Disabled"
                )
            }
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 2)
        }
        .padding(.horizontal)
    }
}

struct PreferenceRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            Text(title)
                .font(.subheadline)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
} 