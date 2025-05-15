import SwiftUI

struct EmptyTripsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "airplane.circle")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No Saved Trips")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Your saved trips will appear here")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
} 