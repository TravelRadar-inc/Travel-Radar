import SwiftUI
import Combine
import Firebase
@MainActor
final class ChatViewModel: ObservableObject{
    @Published var messages = [Message]()
    @Published var mockData = [Message(userUid: "123", text: "dfds", photoURL: "", createdAt: Date()),
    Message(userUid: "123", text: "fdssv", photoURL: "", createdAt: Date())]
    
    //var subscribers: Set<AnyCancellable> = []
    
    func sendMessage(text: String, chatId: String) async throws{
        let authUser = try AuthService.shared.getAuthUser()
        let message = Message(userUid: authUser.uid, text: text, photoURL: authUser.photoURL, createdAt: Date())
        print(messages)
        messages.append(message)
        try await ChatModel(id: chatId).sendMessageToDatabase(message: message)
    }
    
//    init() {
//        Task { [weak self] in
//            do {
//                let authUser = try AuthService.shared.getAuthUser()
//                let messages = try await ChatModel(id: authUser.uid).fetchMessages()
//                self?.messages = messages
//            } catch {
//                print(error)
//            }
//        }
////        subscribeToMessagePublisher()
//    }
    
    func refresh() {
        self.messages = messages
    }
    
//    private func subscribeToMessagePublisher(){
//        let authUser = try? AuthService.shared.getAuthUser()
//        ChatModel(id: authUser?.uid ?? "").messagesPublisher.receive(on: DispatchQueue.main)
//            .sink { completion in
//                print(completion)
//            } receiveValue: { [weak self] messages in
//                self?.messages = messages
//            }
//            .store(in: &subscribers)
//
//    }
    func loadMessages(chatId: String){
        Task{ [weak self] in
            do{
                let messages = try await ChatModel(id: chatId).fetchMessages()
                self?.messages = messages
            }catch{
                print("error")
            }
        }
    }
}

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    @State var text = ""
    @State var isShowMainView = false
    let chatId: String
    var body: some View {
        VStack{
            CustomNavigationBarView(title: "Тех поддержка") {
                isShowMainView.toggle()
            }
            ScrollViewReader{ scrollView in
                ScrollView(showsIndicators: false){
                    VStack(spacing: 8){
                            ForEach(0..<viewModel.messages.count , id: \.self) {idx in
                                MessageView(message: viewModel.messages[idx])
                        }
                        .onChange(of: viewModel.messages) {newValue in
                            scrollView.scrollTo(viewModel.messages.count - 1, anchor: .bottom)
                        }
                    }
                }
            }
            HStack{
                TextField("Message", text: $text, axis: .vertical)
                    .padding()
                Button{
                    Task{
                        do{
                            try await viewModel.sendMessage(text: text, chatId: chatId)
                            text = ""
                        } catch{
                            print("error")
                        }
                    }
                } label: {
                    Text("Send")
                        .padding()
                        .foregroundColor(.white)
                        .background(.cyan)
                        .cornerRadius(50)
                        .padding(.trailing)
                }
            }.background(.ultraThinMaterial)
                .fullScreenCover(isPresented: $isShowMainView, content: {
                    MainAppView()
                })
        } .onAppear{
            viewModel.loadMessages(chatId: chatId)
        }
    }
}

#Preview {
    ChatView(chatId: "uuafOsfGhtbuGmFvhjkckpNliwJ3")
}




