import Foundation
import SwiftUI

struct EmailSection: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var isShowAlert:Bool
    @Binding var alertMessage:String
    var body: some View {
        Section{
            Button(action: {
                Task{
                    do{
                        try await viewModel.updateEmail()
                        print("Email update")
                    }
                    catch{
                        self.alertMessage = "\(error.localizedDescription)"
                        self.isShowAlert.toggle()
                    }
                }
            }, label: {
                Text("Поменять почту")
            })
            Button(action: {
                Task{
                    do{
                        try await viewModel.updatePassword()
                        print("Password update")
                    }
                    catch{
                        self.alertMessage = "\(error.localizedDescription)"
                        self.isShowAlert.toggle()
                    }
                }
            }, label: {
                Text("Поменять пароль")
            })
        } header: {
            Text("Email funcions")
                //.padding(.top, 50)
        }
    }
}
