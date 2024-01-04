import SwiftUI
import Foundation

struct DeleteAccount: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var isShowContentView: Bool
    @Binding var isShowAlert:Bool
    @Binding var alertMessage:String
    var body: some View {
        Button(role: .destructive, action: {
            Task{
                do{
                    try await viewModel.deleteAccount()
                    isShowContentView.toggle()
                }
                catch{
                    self.alertMessage = "\(error.localizedDescription)"
                    self.isShowAlert.toggle()
                }
            }
            
        }, label: {
            Text("Удалить аккаунт")
        })
        
        .alert(alertMessage, isPresented: $isShowAlert) {
            Button{} label: {
            }
        }
    }
}
