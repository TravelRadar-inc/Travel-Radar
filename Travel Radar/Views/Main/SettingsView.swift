import SwiftUI
@MainActor

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State var isShowMap = false
    @State var isShowContentView = false
    @State var isShowAlert = false
    @State var alertMessage = ""
    var body: some View {
        List{
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
            }
        
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
            }).alert(alertMessage, isPresented: $isShowAlert) {
                Button{} label: {
                }
            }
            
        }.navigationBarTitle("Настройки")
        .fullScreenCover(isPresented: $isShowMap, content: {MainAppView()})
        .fullScreenCover(isPresented: $isShowContentView, content: {LogInView()})
    }
}
struct SettingsView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationStack{
            SettingsView()
        }
    }
}
