import SwiftUI

struct FavoritePlacesSection: View {
    let places: [Place]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Favorite Places")
                .font(.headline)
                .padding(.horizontal)
            
            if places.isEmpty {
                EmptyFavoritesView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(places) { place in
                            DestinationCard(place: place)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct EmptyFavoritesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No Favorite Places")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Add places to your favorites to see them here")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
} 
