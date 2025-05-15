import SwiftUI

struct TripsView: View {
    @StateObject private var viewModel = TripsViewModel()
    @State private var showingNewTripSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Status Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(Trip.TripStatus.allCases, id: \.self) { status in
                            StatusButton(
                                status: status,
                                isSelected: viewModel.selectedTripStatus == status,
                                action: {
                                    if viewModel.selectedTripStatus == status {
                                        viewModel.selectedTripStatus = nil
                                    } else {
                                        viewModel.selectedTripStatus = status
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
                
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.filterTrips().isEmpty {
                    EmptyTripsView()
                } else {
                    List {
                        ForEach(viewModel.filterTrips()) { trip in
                            NavigationLink(destination: TripDetailView(trip: trip)) {
                                TripRowView(trip: trip)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("My Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingNewTripSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewTripSheet) {
                NewTripView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.fetchTrips()
        }
    }
}

struct StatusButton: View {
    let status: Trip.TripStatus
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(status.rawValue.capitalized)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
    }
}

struct TripRowView: View {
    let trip: Trip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(trip.name)
                .font(.headline)
            
            HStack {
                Image(systemName: "mappin.circle.fill")
                Text(trip.destination)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "calendar")
                Text("\(trip.startDate.formatted(date: .abbreviated, time: .omitted)) - \(trip.endDate.formatted(date: .abbreviated, time: .omitted))")
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
        .padding(.vertical, 8)
    }
}

struct NewTripView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TripsViewModel
    
    @State private var name = ""
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var budget = 0.0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trip Details")) {
                    TextField("Trip Name", text: $name)
                    TextField("Destination", text: $destination)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    TextField("Budget", value: $budget, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("New Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        viewModel.createNewTrip(
                            name: name,
                            destination: destination,
                            startDate: startDate,
                            endDate: endDate,
                            budget: budget
                        )
                        dismiss()
                    }
                    .disabled(name.isEmpty || destination.isEmpty)
                }
            }
        }
    }
}

extension Trip.TripStatus: CaseIterable {
    static var allCases: [Trip.TripStatus] {
        [.planning, .ongoing, .completed, .cancelled]
    }
}

#Preview {
    TripsView()
} 