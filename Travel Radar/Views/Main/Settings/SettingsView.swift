import SwiftUI
@MainActor

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State var isShowMap = false
    @State var isShowContentView = false
    @State var isShowAlert = false
    @State var alertMessage = ""
    @State var check = false
    var body: some View {
        NavigationStack{
            List{
                if viewModel.authProviders.contains(.email){
                    EmailSection(isShowAlert: $isShowAlert, alertMessage: $alertMessage)
                }
                
                LogOut(isShowContentView: $isShowContentView, isShowAlert: $isShowAlert, alertMessage: $alertMessage)
                    .alert(alertMessage, isPresented: $isShowAlert) {
                        Button{} label: {
                        }
                    }
            }
            .padding(.top,50)
            
        }.onAppear{
            viewModel.loadAuthProviders()}
        //.navigationBarTitle("Настройки")
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
