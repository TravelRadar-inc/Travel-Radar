import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth
struct GoogleSignInrResultModel{
    let idToken:String
    let accessToken:String
}
@MainActor
class AuthGoogleViewModel: ObservableObject{
    func singInGoogle() async throws{
        guard let topVC = Utilities.shared.topViewController() else{
            throw URLError(.cannotFindHost)
        }
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignInrResultModel(idToken: idToken, accessToken: accessToken)
        try await AuthService.shared.signInWithGoogle(tokens: tokens)
    }
}
struct RegisterView: View {
    @StateObject var viewModel = AuthGoogleViewModel()
    @State var isShowingRegister2View = false
    @State var isShowingContentView = false
    @State var isShowMapView = false
    @State var isShowAlert = false
    @State var alertMessage = ""
    var body: some View {
        ZStack{
            BackgroundMain()
            VStack{
                TextRedisterView(text: "Хотите легко путешествовать?")
                TextRedisterView(text: "Присоединяйтесь к нам")
                    .padding(.bottom, 300)
                Spacer()
                Button(action: {
                    isShowingRegister2View.toggle()
                }, label: {
                    ButtonRegisterView()
                })
                Button(action: {
                    
                }, label: {
                    ButtonRegisterImageView(imageName: "icons8-apple",
                                       text: "Войти с помощью Apple   ")
                })
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
                    Task{
                        do{
                            try await viewModel.singInGoogle()
                            isShowMapView.toggle()
                        }
                        catch{
                            alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                            self.isShowAlert.toggle()
                        }
                    }
                }
                .cornerRadius(20)
                .frame(width: 300)
                .padding(.horizontal, 40)
                Spacer()
                Button(action: {
                    isShowingContentView.toggle()
                }, label: {
                    ButtonMini(text: "Уже есть аккаунт?")
                })
            }.fullScreenCover(isPresented: $isShowingRegister2View, content: {
                RegisterView2()})
            .fullScreenCover(isPresented: $isShowingContentView, content: {
               ContentView()})
            .fullScreenCover(isPresented: $isShowMapView, content: {
                MapView()
            .alert(alertMessage, isPresented: $isShowAlert) {
                Button{} label: {
                }
            }
            })
        }
    }
}

#Preview {
    RegisterView()
}

