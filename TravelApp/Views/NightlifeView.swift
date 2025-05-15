import SwiftUI
import Foundation

struct NightlifeView: View {
    @StateObject private var viewModel = NightlifeViewModel()
    @State private var showingEventDetail = false
    @State private var selectedEvent: Event?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Date Picker
                DatePicker(
                    "Select Date",
                    selection: $viewModel.selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .padding()
                
                // Category Filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(EventCategory.allCases, id: \.self) { category in
                            EventCategoryButton(
                                category: category,
                                isSelected: viewModel.selectedCategory == category,
                                action: {
                                    if viewModel.selectedCategory == category {
                                        viewModel.selectedCategory = nil
                                    } else {
                                        viewModel.selectedCategory = category
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
                } else if viewModel.filterEvents().isEmpty {
                    EmptyEventsView()
                } else {
                    List {
                        ForEach(viewModel.filterEvents()) { event in
                            EventRow(event: event)
                                .onTapGesture {
                                    selectedEvent = event
                                    showingEventDetail = true
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Nightlife")
            .sheet(isPresented: $showingEventDetail) {
                if let event = selectedEvent {
                    EventDetailView(event: event)
                }
            }
        }
        .onAppear {
            viewModel.fetchEvents()
        }
    }
}

struct EventCategoryButton: View {
    let category: EventCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category.rawValue.capitalized)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.1))
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
    }
}

struct EventRow: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let firstImage = event.images.first {
                AsyncImage(url: URL(string: firstImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Text(event.name)
                .font(.headline)
            
            Text(event.venue.name)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: "clock")
                Text("\(event.startTime.formatted(date: .omitted, time: .shortened)) - \(event.endTime.formatted(date: .omitted, time: .shortened))")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            HStack {
                Text("$\(event.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text("\(event.ticketAvailability) tickets left")
                    .font(.subheadline)
                    .foregroundColor(event.ticketAvailability < 10 ? .red : .secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

struct EmptyEventsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "moon.stars.fill")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No Events Found")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Try selecting a different date or category")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .systemBackground))
    }
}

struct EventDetailView: View {
    let event: Event
    @Environment(\.dismiss) private var dismiss
    @State private var showingTicketPurchase = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Event Image
                    if let firstImage = event.images.first {
                        AsyncImage(url: URL(string: firstImage)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray
                        }
                        .frame(height: 250)
                        .clipShape(Rectangle())
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Event Details
                        Text(event.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(event.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        // Date and Time
                        VStack(alignment: .leading, spacing: 8) {
                            DetailRow(icon: "calendar", text: event.date.formatted(date: .long, time: .omitted))
                            DetailRow(icon: "clock", text: "\(event.startTime.formatted(date: .omitted, time: .shortened)) - \(event.endTime.formatted(date: .omitted, time: .shortened))")
                        }
                        
                        // Venue
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Venue")
                                .font(.headline)
                            
                            Text(event.venue.name)
                                .font(.subheadline)
                            
                            Text(event.venue.address)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // Performers
                        if !event.performers.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Performers")
                                    .font(.headline)
                                
                                ForEach(event.performers, id: \.self) { performer in
                                    Text("• \(performer)")
                                        .font(.subheadline)
                                }
                            }
                        }
                        
                        // Price and Availability
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Price")
                                    .font(.headline)
                                Text("$\(event.price, specifier: "%.2f")")
                                    .font(.title3)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Tickets Left")
                                    .font(.headline)
                                Text("\(event.ticketAvailability)")
                                    .font(.title3)
                                    .foregroundColor(event.ticketAvailability < 10 ? .red : .primary)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Buy Tickets") {
                        showingTicketPurchase = true
                    }
                    .disabled(event.ticketAvailability == 0)
                }
            }
            .sheet(isPresented: $showingTicketPurchase) {
                TicketPurchaseView(event: event)
            }
        }
    }
}

struct DetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(text)
                .font(.subheadline)
        }
    }
}

struct TicketPurchaseView: View {
    let event: Event
    @Environment(\.dismiss) private var dismiss
    @State private var quantity = 1
    
    var totalPrice: Double {
        event.price * Double(quantity)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Ticket Details")) {
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 1...event.ticketAvailability)
                    
                    HStack {
                        Text("Price per ticket")
                        Spacer()
                        Text("$\(event.price, specifier: "%.2f")")
                    }
                    
                    HStack {
                        Text("Total")
                            .fontWeight(.bold)
                        Spacer()
                        Text("$\(totalPrice, specifier: "%.2f")")
                            .fontWeight(.bold)
                    }
                }
                
                Section {
                    Button("Purchase") {
                        // TODO: Implement purchase logic
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .navigationTitle("Buy Tickets")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NightlifeView()
} 