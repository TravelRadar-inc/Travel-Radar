import SwiftUI
import SDWebImageSwiftUI
struct MessageView: View {
    var message: Message
    var body: some View {
        if message.isFromCurrentUser(){
            HStack{
                Text(message.text)
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

                
                Text(message.text)
                    .padding()
                    .frame(maxWidth: 260,alignment: .leading)
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

struct Message: Decodable, Identifiable{
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
