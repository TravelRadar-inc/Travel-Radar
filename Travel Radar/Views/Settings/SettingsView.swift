import SwiftUI
import MapKit
import Firebase
@MainActor

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State var isShowMap = false
    @State var isShowContentView = false
    @State var isShowAlert = false
    @State var isShowingStylePicker = false
    @State var alertMessage = ""
    @State var check = false
    @State var frame1color: Color = .blue
    @State var frame2color: Color = .black
    var body: some View {
        NavigationStack{
            List{
                if viewModel.authProviders.contains(.email){
                    EmailSection(isShowAlert: $isShowAlert, alertMessage: $alertMessage)
                }
                //UpdateUserSectionView()
                if let user = Auth.auth().currentUser{
                    if user.uid != "M0utShwhVqgrtBI2TI2yKo0eNfR2" && user.uid != "YOSCUB796wfe6xWk8zpoxNluKH62"{
                        TechnicalSupportView()
                    }else{}
                }
                
                LogOut(isShowContentView: $isShowContentView, isShowAlert: $isShowAlert, alertMessage: $alertMessage)
                DeleteAccount(isShowContentView: $isShowContentView, isShowAlert: $isShowAlert, alertMessage: $alertMessage)
            }
            .padding(.top,50)
            
        }.onAppear{
            viewModel.loadAuthProviders()}
        .fullScreenCover(isPresented: $isShowMap, content: {MainAppView()})
        .fullScreenCover(isPresented: $isShowContentView, content: {MainLogInView()})
    }
}

#Preview
{
    SettingsView()
}


