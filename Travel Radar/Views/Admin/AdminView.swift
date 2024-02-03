import SwiftUI

@MainActor
final class AdminViewModel: ObservableObject{
    @Published var messages = [Message]()
    @Published var mockData = [Message(userUid: "123", text: "dfds", photoURL: "", createdAt: Date()),
    Message(userUid: "123", text: "fdssv", photoURL: "", createdAt: Date())]
    
//    init(){
//        DatabaseManager.shared.fetchMessage{ [weak self] result in
//            switch result{
//            case .success(let msgs):
//                self?.messages=msgs
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    func sendMessage(text: String) async throws{
        let authUser = try AuthService.shared.getAuthUser()
        let msg = Message(userUid: authUser.uid, text: text, photoURL: authUser.photoURL, createdAt: Date())
        print(messages)
        try await DatabaseManager.shared.sendMessageToDatabase(message: msg)
    }
    init() {
        Task { [weak self] in
            do {
                let messages = try await DatabaseManager.shared.fetchMessages()
                self?.messages = messages
            } catch {
                print(error)
            }
        }
    }
}

struct AdminView: View {
    @StateObject var viewModel = AdminViewModel()
    @State var text = ""
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView(showsIndicators: false){
                    VStack(spacing: 8){
                        ForEach(viewModel.messages) {message in MessageView(message:message)}
                    }
                }
                HStack{
                    TextField("Message", text: $text, axis: .vertical)
                        .padding()
                    Button{
                        Task{
                            do{
                                try await viewModel.sendMessage(text: text)
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
            }
        }.navigationTitle("Техподдержка")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AdminView()
}

