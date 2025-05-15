import SwiftUI

struct ChatView: View {
    @State private var message = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hello! How can I help you?", isMe: false),
        ChatMessage(text: "I'm looking for hotels in Stockholm", isMe: true),
        ChatMessage(text: "I can help you find the perfect hotel. What's your budget?", isMe: false)
    ]

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isMe { Spacer() }
                            Text(message.text)
                                .padding()
                                .background(message.isMe ? Color.blue : Color(uiColor: .systemGray6))
                                .foregroundColor(message.isMe ? .white : .primary)
                                .cornerRadius(16)
                            if !message.isMe { Spacer() }
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
                        messages.append(ChatMessage(text: message, isMe: true))
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

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isMe: Bool
}

#Preview {
    ChatView()
} 