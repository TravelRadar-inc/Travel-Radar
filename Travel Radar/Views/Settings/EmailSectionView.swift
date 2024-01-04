import Foundation
import SwiftUI

struct EmailSection: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var isShowAlert:Bool
    @Binding var alertMessage:String
    @State var isShowUpdatePasswordView = false
    @State var isShowUpdateEmailView = false
    var body: some View {
        Section{
            NavigationLink{
                UpdatePasswordView()
            } label: {
                Text("Поменять пароль")
            }
        } header: {
            Text("Email funcions")
        }
    }
}
