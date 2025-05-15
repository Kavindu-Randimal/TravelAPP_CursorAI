import SwiftUI

struct TripDetailView: View {
    let trip: Trip
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // Trip Header
            VStack(alignment: .leading, spacing: 8) {
                Text(trip.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                HStack {
                    Image(systemName: "mappin.circle.fill")
                    Text(trip.destination)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "calendar")
                    Text("\(trip.startDate.formatted(date: .long, time: .omitted)) - \(trip.endDate.formatted(date: .long, time: .omitted))")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Budget: $\(trip.budget, specifier: "%.2f")")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemBackground))
            
            // Tab View
            Picker("View", selection: $selectedTab) {
                Text("Overview").tag(0)
                Text("Accommodations").tag(1)
                Text("Activities").tag(2)
                Text("Transportation").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Content
            TabView(selection: $selectedTab) {
                TripOverviewView(trip: trip)
                    .tag(0)
                
                AccommodationsView(accommodations: trip.accommodations)
                    .tag(1)
                
                ActivitiesView(activities: trip.activities)
                    .tag(2)
                
                TransportationView(transportation: trip.transportation)
                    .tag(3)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TripOverviewView: View {
    let trip: Trip
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Trip Status
                HStack {
                    Text("Status:")
                        .font(.headline)
                    Text(trip.status.rawValue.capitalized)
                        .foregroundColor(.secondary)
                }
                
                // Summary Cards
                VStack(spacing: 15) {
                    SummaryCard(
                        title: "Accommodations",
                        count: trip.accommodations.count,
                        icon: "bed.double.fill"
                    )
                    
                    SummaryCard(
                        title: "Activities",
                        count: trip.activities.count,
                        icon: "figure.hiking"
                    )
                    
                    SummaryCard(
                        title: "Transportation",
                        count: trip.transportation.count,
                        icon: "car.fill"
                    )
                }
            }
            .padding()
        }
    }
}

struct SummaryCard: View {
    let title: String
    let count: Int
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text("\(count) items")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct AccommodationsView: View {
    let accommodations: [Accommodation]
    
    var body: some View {
        List {
            ForEach(accommodations) { accommodation in
                AccommodationRow(accommodation: accommodation)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct AccommodationRow: View {
    let accommodation: Accommodation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(accommodation.name)
                .font(.headline)
            
            Text(accommodation.type)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(accommodation.address)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text("$\(accommodation.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", accommodation.rating))
                }
                .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
    }
}

struct ActivitiesView: View {
    let activities: [Activity]
    
    var body: some View {
        List {
            ForEach(activities) { activity in
                ActivityRow(activity: activity)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ActivityRow: View {
    let activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(activity.name)
                .font(.headline)
            
            Text(activity.type.rawValue.capitalized)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(activity.location)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text("$\(activity.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text(activity.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

struct TransportationView: View {
    let transportation: [Transportation]
    
    var body: some View {
        List {
            ForEach(transportation) { transport in
                TransportationRow(transportation: transport)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct TransportationRow: View {
    let transportation: Transportation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: iconForType(transportation.type))
                    .foregroundColor(.blue)
                Text(transportation.type.rawValue.capitalized)
                    .font(.headline)
            }
            
            Text(transportation.provider)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text(transportation.departureTime.formatted(date: .abbreviated, time: .shortened))
                Image(systemName: "arrow.right")
                Text(transportation.arrivalTime.formatted(date: .abbreviated, time: .shortened))
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            HStack {
                Text("$\(transportation.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text(transportation.status.rawValue.capitalized)
                    .font(.subheadline)
                    .foregroundColor(statusColor(transportation.status))
            }
        }
        .padding(.vertical, 8)
    }
    
    private func iconForType(_ type: Transportation.TransportationType) -> String {
        switch type {
        case .flight: return "airplane"
        case .train: return "tram.fill"
        case .bus: return "bus.fill"
        case .car: return "car.fill"
        case .boat: return "ferry.fill"
        }
    }
    
    private func statusColor(_ status: Transportation.TransportationStatus) -> Color {
        switch status {
        case .booked: return .orange
        case .confirmed: return .green
        case .completed: return .blue
        case .cancelled: return .red
        }
    }
}

#Preview {
    NavigationView {
        TripDetailView(trip: Trip(
            id: "1",
            name: "Summer Vacation",
            startDate: Date(),
            endDate: Date().addingTimeInterval(7*24*60*60),
            destination: "Paris, France",
            budget: 2000,
            accommodations: [],
            activities: [],
            transportation: [],
            status: .planning
        ))
    }
} 