import SwiftUI

struct ProfileHeader: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 16) {
            if let profileImage = user.profileImage {
                AsyncImage(url: URL(string: profileImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
            
            Text(user.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(user.email)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
} 