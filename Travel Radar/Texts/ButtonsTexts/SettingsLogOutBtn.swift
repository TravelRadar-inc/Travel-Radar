
import Foundation
import SwiftUI
struct LogOut: View {
    @StateObject private var viewModel = SettingsViewModel()
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
