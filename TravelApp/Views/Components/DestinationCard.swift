import SwiftUI

struct DestinationCard: View {
    let place: Place

    var body: some View {
        VStack {
            if let imageName = place.images.first {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .clipped()
            } else {
                Color.gray.frame(height: 120)
            }
            Text(place.name)
                .font(.headline)
                .padding(.top, 8)
            Text(place.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .frame(width: 180)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
} 