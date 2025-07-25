import SwiftUI
import MapKit

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Image(systemName: "house.fill"); Text("Home") }
            CarRentalListView()
                .tabItem { Image(systemName: "car.fill"); Text("Cars") }
            EventListView()
                .tabItem { Image(systemName: "calendar"); Text("Events") }
            ChatView()
                .tabItem { Image(systemName: "message.fill"); Text("Chat") }
            MapScreenView()
                .tabItem { Image(systemName: "map.fill"); Text("Map") }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
} 
