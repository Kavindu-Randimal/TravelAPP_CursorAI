import SwiftUI

struct EventListView: View {
    var events: [SimpleEvent] = [
        SimpleEvent(id: "1", title: "Mirissa Beach Party", date: Date()),
        SimpleEvent(id: "2", title: "Stockholm Festival", date: Date().addingTimeInterval(86400 * 30))
    ]

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
            Rectangle()
                .fill(Color.blue)
                .frame(width: 100, height: 60)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.headline)
                Text(event.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
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

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
} 