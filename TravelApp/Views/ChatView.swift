import SwiftUI

struct ChatView: View {
    @State private var message = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(id: "1", senderId: "bot", text: "Hello! How can I help you?", timestamp: Date()),
        ChatMessage(id: "2", senderId: "me", text: "I'm looking for hotels in Stockholm", timestamp: Date()),
        ChatMessage(id: "3", senderId: "bot", text: "I can help you find the perfect hotel. What's your budget?", timestamp: Date())
    ]

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(messages) { message in
                        HStack {
                            if message.senderId == "me" { Spacer() }
                            Text(message.text)
                                .padding()
                                .background(message.senderId == "me" ? Color.blue : Color(uiColor: .systemGray6))
                                .foregroundColor(message.senderId == "me" ? .white : .primary)
                                .cornerRadius(16)
                            if message.senderId != "me" { Spacer() }
                        }
                    }
                }
                .padding()
            }

            HStack {
                TextField("Type a message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: {
                    if !message.isEmpty {
                        messages.append(ChatMessage(id: UUID().uuidString, senderId: "me", text: message, timestamp: Date()))
                        message = ""
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                }
                .padding(.trailing)
            }
            .padding(.vertical)
        }
        .navigationTitle("Chat")
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
} 