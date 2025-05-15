import SwiftUI

struct HotelListView: View {
    var hotels: [Hotel] = Hotel.sampleHotels

    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                HStack {
                    TextField("Stockholm, Sweden", text: .constant(""))
                        .padding(10)
                        .background(Color(uiColor: .systemGray6))
                        .cornerRadius(11)
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue)
                }
                .padding()

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(hotels) { hotel in
                            HotelCard(hotel: hotel)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Hotels")
        }
    }
}

struct HotelCard: View {
    let hotel: Hotel

    var body: some View {
        HStack {
            Image(hotel.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 80)
                .cornerRadius(12)
                .clipped()
            VStack(alignment: .leading, spacing: 6) {
                Text(hotel.name)
                    .font(.headline)
                HStack(spacing: 2) {
                    ForEach(0..<5) { i in
                        Image(systemName: i < hotel.stars ? "star.fill" : "star")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                }
                Text("\(hotel.price) kr per night")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "bookmark")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 0, y: 2)
    }
}
#Preview {
    HotelListView()
} 
