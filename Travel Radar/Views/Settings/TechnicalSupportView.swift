import SwiftUI
import Firebase


final class TechnicalSupportViewModel: ObservableObject{
    @Published var authUser: AuthDataResultModel? = nil
    
    func loadUser() {
        self.authUser = try? AuthService.shared.getAuthUser()
    }
    func creatNewChat() async throws{
        let authUser = try AuthService.shared.getAuthUser()
        let chat = Chat(id: authUser.uid ,participant: [authUser.uid, "M0utShwhVqgrtBI2TI2yKo0eNfR2", "mDMX2tTyvYfM8qtCRWdgaMaMa7l2"])
        try await DataBaseMananger.shared.creatNewChat(chat: chat)
        
    }
    
}

struct TechnicalSupportView: View {
    @StateObject var viewModel = TechnicalSupportViewModel()
    @State var isShowChatView = false
    let authUser = try? AuthService.shared.getAuthUser()
    var body: some View {
        Section{
            if viewModel.authUser?.isAnonymous == true{
                Text("Чтобы пользоваться техподдержкой, войдите в аккаунт")
                    .foregroundColor(.black)
            }else{
                Button(action: {
                    Task{
                        do{
                            try await viewModel.creatNewChat()
                        }
                    }
                    isShowChatView.toggle()
                }, label: {
                    Text("Техническая поддержка")
                        .foregroundColor(.black)
                })
            }
        } header: {
            Text("Тех поддержка")
        }.fullScreenCover(isPresented: $isShowChatView, content: {
            ChatView(chatId: authUser?.uid ?? "1")
        })
        .onAppear{
            viewModel.loadUser()
        }
    }
}


#Preview {
    TechnicalSupportView()
}
