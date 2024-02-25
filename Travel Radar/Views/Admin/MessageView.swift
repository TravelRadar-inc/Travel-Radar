import SwiftUI
import SDWebImageSwiftUI

final class MessageViewModel: ObservableObject{
    func dateToString(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm dd.MM.yyyy"
            return formatter.string(from: date)
        }
}

struct MessageView: View {
    @StateObject var viewModel = MessageViewModel()
    var message: Message
    var body: some View {
        if message.isFromCurrentUser(){
            HStack{
                VStack(alignment: .leading, spacing: 0) {
                    Text(message.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(viewModel.dateToString(date: message.createdAt))
                        .font(.system(size: 12))
                        .frame(alignment: .bottomTrailing)
                }
                .padding()
                .frame(maxWidth: 260,alignment: .topLeading)
                .background(.blue)
                .cornerRadius(20)
                if let photoURL = message.fetchPhotoURL(){
                    WebImage(url: photoURL)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .padding(.bottom, 16)
                        .padding(.leading, 4)
                } else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .padding(.bottom, 16)
                        .padding(.leading, 4)
                }
            }
            .frame(maxWidth: 360, alignment: .trailing)
        }
        else{
            HStack{
                if let photoURL = message.fetchPhotoURL(){
                    WebImage(url: photoURL)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .padding(.bottom, 16)
                        .padding(.leading, 4)
                } else{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .top)
                        .padding(.bottom, 16)
                        .padding(.leading, 4)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text(message.text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                    HStack {
                        Spacer()
                        Text(viewModel.dateToString(date: message.createdAt))
                            .font(.system(size: 12))
                            .frame(alignment: .bottomTrailing)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .frame(maxWidth: 260, alignment: .leading)
                .background(Color(uiColor: .lightGray))
                .cornerRadius(20)

            }
            .frame(maxWidth: 360, alignment: .leading)
        }
                
    }
}

#Preview {
    MessageView(message: Message(userUid: "123", text: "Hello", photoURL: "", createdAt: Date()))
}

struct Message: Decodable, Identifiable, Equatable, Hashable{
    let id = UUID()
    let userUid: String
    let text: String
    let photoURL: String?
    let createdAt: Date
    
    enum MessageError: Error {
        case noPhotoURL
    }
    
    func isFromCurrentUser() -> Bool{
        guard let authUser = try? AuthService.shared.getAuthUser() else{
            return false
        }
        if authUser.uid == userUid{
            return true
        }else{
            return false
        }
    }
    
    func fetchPhotoURL()  -> URL? {
        guard let photoURLString = photoURL, let url = URL(string: photoURLString) else{
            return nil
        }
        return url
    }
}
