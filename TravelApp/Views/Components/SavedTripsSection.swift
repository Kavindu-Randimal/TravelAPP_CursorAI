import SwiftUI

struct SavedTripsSection: View {
    let trips: [Trip]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Saved Trips")
                .font(.headline)
                .padding(.horizontal)
            
            if trips.isEmpty {
                EmptyTripsView()
            } else {
                ForEach(trips) { trip in
                    TripRowView(trip: trip)
                        .padding(.horizontal)
                }
            }
        }
    }
} 