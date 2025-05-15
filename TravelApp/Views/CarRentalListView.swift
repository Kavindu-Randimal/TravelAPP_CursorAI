import SwiftUI

struct CarRentalListView: View {
    var cars: [Car] = Car.sampleCars

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(cars) { car in
                        CarCard(car: car)
                    }
                }
                .padding()
            }
            .navigationTitle("Car Rentals")
        }
    }
}

struct CarCard: View {
    let car: Car

    var body: some View {
        HStack {
            Image(car.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 60)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(car.name)
                    .font(.headline)
                Text(car.type)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(car.price) kr")
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
    CarRentalListView()
} 