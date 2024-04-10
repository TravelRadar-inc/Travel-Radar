import SwiftUI
import SDWebImageSwiftUI
struct ChatForAdminView: View {
    @StateObject var viewModel = MessageViewModel()
    @State var isShowChatView = false
    var message: Message
    var user: DBUser
    var body: some View {
        Button(action: {
            isShowChatView.toggle()
            print("hello")
        }, label: {
            HStack(alignment: .top, spacing: 15) {
                if let photoURL = user.fetchPhotoURL(){
                    WebImage(url: photoURL)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading, spacing: 5) {
                    if let name = user.name{
                        Text(name)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    } else if let email = user.email{
                        Text(email)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    } else{
                        Text("error")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    Text(message.text)
                        .lineLimit(1)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    Text(viewModel.dateToString(date: message.createdAt))
                        .fontWeight(.light)
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
            }
            
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.purple.opacity(0.3)) // Фоновый цвет с прозрачностью
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple, lineWidth: 2) // Цвет границы
            )
            .padding(.horizontal)
            .fullScreenCover(isPresented: $isShowChatView, content: {
                ChatView(chatId: user.userId)
            })
        })
    }
    
}

#Preview {
    ChatForAdminView(message: Message(userUid: "1", text: "Hello", photoURL: "1", createdAt: Date()), user: DBUser(userId: "1", email: "piffors", photoURL: "1", name: "Mikhail", dateCreated: Date()))
}
