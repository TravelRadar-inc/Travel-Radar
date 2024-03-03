import SwiftUI


@MainActor
final class AdminViewForAdminViewModel: ObservableObject{
    @Published var chats = [Chat]()
    @Published var test = [1,2,3,4,5]
    @Published var lastMessages = [String: Message]() // chatId: Message
    @Published var userInfos = [String: DBUser]() // chatId: DBUser
    @Published var user = DBUser(userId: "1", email: "1", photoURL: "1", name: "1", dateCreated: Date())
    @Published var message = Message(userUid: "1", text: "1", photoURL: "1", createdAt: Date())
//    init(){
//        Task{ [weak self] in
//            do{
//                let chats = try await DataBaseMananger.shared.fetchChats()
//                self?.chats = chats
//                print(chats.count)
//            }catch{
//                print("error")
//            }
//        }
//    }
    func loadChats(){
        Task{
            do{
                let chats = try await DataBaseMananger.shared.fetchChats()
                self.chats = chats
                //print(chats.count)
                self.unwrappening()
            }catch{
                //print("error")
            }
        }
    }
    
    func fetchInfo(chatId: String) async throws-> DBUser{
        let info = try await UserMananger.shared.fetchUser(userId: chatId)
        return DBUser(userId: info.userId, email: info.email, photoURL: info.photoURL, name: info.name, dateCreated: info.dateCreated)
    }
    
    func fetchLastMessage(chatId:String) async throws  -> Message{
        let messages = try await ChatModel(id: chatId).fetchMessages()
        if let lastElement = messages.last{
            return lastElement
        } else{
            return Message(userUid: "1", text: "1", photoURL: "1", createdAt: Date())
        }
    }
    
    func unwrappening() {
        Task{
            for chat in chats {
                do{
                    let user = try await fetchInfo(chatId: chat.id)
                    let message = try await fetchLastMessage(chatId: chat.id)
                    self.lastMessages[chat.id] = message
                    self.userInfos[chat.id] = user
                    //print(1234)
                } catch{
                    //print("error")
                }
            }
        }
    }
}

struct AdminViewForAdmin: View {
    @StateObject var viewModel = AdminViewForAdminViewModel()
    var body: some View{
        VStack{
            HStack{
                Text("Вопросы")
                    .font(.headline)
                    .frame(alignment: .center)
                    .foregroundColor(.black)
            }
            .padding()
            ScrollView(showsIndicators: false){
                VStack{
                    ForEach(0..<viewModel.chats.count, id: \.self){index in
                        if let message = viewModel.lastMessages[viewModel.chats[index].id], let user = viewModel.userInfos[viewModel.chats[index].id]{
                            ChatForAdminView(message: message, user: user)
                        }
                        //test()
                    }
                } .onAppear{
                    viewModel.loadChats()
                }
            }
        }
    }
}
#Preview {
    AdminViewForAdmin()
}
