
import Foundation
import SwiftUI
final class LogOutViewModel: ObservableObject{
    @Published var authUser: AuthDataResultModel? = nil
    
    func loadUser() {
        self.authUser = try? AuthService.shared.getAuthUser()
    }
}

struct LogOut: View {
    @StateObject private var viewModel = SettingsViewModel()
    @StateObject private var viewModel2 = LogOutViewModel()
    @Binding var isShowContentView: Bool
    @Binding var isShowAlert:Bool
    @Binding var alertMessage:String
    var body: some View {
        Button(action: {
            Task{
                do{
                    try viewModel.signOut()
                    isShowContentView.toggle()
                }
                catch{
                    self.alertMessage = "\(error.localizedDescription)"
                    self.isShowAlert.toggle()
                }
            }
        }, label: {
            Text("Выйти из аккаунта")
        })
        
    }
}
