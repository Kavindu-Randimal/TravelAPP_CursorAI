import SwiftUI
import MapKit

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search and Filter Bar
                VStack(spacing: 10) {
                    SearchBar(text: $viewModel.searchQuery)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(Place.PlaceType.allCases, id: \.self) { category in
                                CategoryButton(
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
                }
                .padding(.vertical)
                .background(Color(.systemBackground))
                
                // Map View
                Map(coordinateRegion: $region, annotationItems: viewModel.filterPlaces()) { place in
                    MapAnnotation(coordinate: place.coordinates) {
                        PlaceAnnotationView(place: place)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchNearbyPlaces()
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search places...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.horizontal)
    }
}

struct CategoryButton: View {
    let category: Place.PlaceType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(category.rawValue.capitalized)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
    }
}

struct PlaceAnnotationView: View {
    let place: Place
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }
    }
}

extension Place.PlaceType: CaseIterable {
    static var allCases: [Place.PlaceType] {
        [.hotel, .restaurant, .attraction, .nightclub, .beach, .shopping, .museum]
    }
}

#Preview {
    ExploreView()
} 