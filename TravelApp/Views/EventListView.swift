import SwiftUI

struct EventListView: View {
    var events: [SimpleEvent] = SimpleEvent.sampleEvents

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(events) { event in
                        EventCard(event: event)
                    }
                }
                .padding()
            }
            .navigationTitle("Events")
        }
    }
}

struct EventCard: View {
    let event: SimpleEvent

    var body: some View {
        HStack {
            Image(event.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 60)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
                Text(event.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(event.date)
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

struct SimpleEvent: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let date: String
    let imageName: String

    static let sampleEvents: [SimpleEvent] = [
        SimpleEvent(name: "Mirissa Beach Party", location: "Mirissa", date: "2024-07-10", imageName: "event1"),
        SimpleEvent(name: "Stockholm Festival", location: "Stockholm", date: "2024-08-15", imageName: "event2")
    ]
}

#Preview {
    EventListView()
} 