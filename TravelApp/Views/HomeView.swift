import SwiftUI

struct HomeView: View {
    @State private var location: String = ""
    @State private var fromDate: Date = Date()
    @State private var toDate: Date = Date().addingTimeInterval(86400)
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Top Search Bar
                VStack(spacing: 12) {
                    TextField("Search destinations, hotels, or events", text: $location)
                        .padding()
                        .background(Color(uiColor: .systemGray6))
                        .cornerRadius(12)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                                .padding(.leading, 8 )
                        )
                    
                    HStack {
                        DatePicker("From", selection: $fromDate, displayedComponents: .date)
                            .labelsHidden()
                        DatePicker("To", selection: $toDate, displayedComponents: .date)
                            .labelsHidden()
                    }
                }
                .padding(.horizontal)
                
                // Main Menu Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    MenuButton(title: "Hotels", icon: "bed.double.fill", color: .blue)
                    MenuButton(title: "Transport", icon: "car.fill", color: .blue)
                    MenuButton(title: "Guide", icon: "person.2.fill", color: .blue)
                    MenuButton(title: "Night life & event", icon: "moon.stars.fill", color: .blue)
                    MenuButton(title: "Social trip mapping", icon: "map.fill", color: .blue)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarTitle("WanderWise", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "bell")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct MenuButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(color)
                .clipShape(Circle())
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color(uiColor: .systemGray4), radius: 4, x: 0, y: 2)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 
