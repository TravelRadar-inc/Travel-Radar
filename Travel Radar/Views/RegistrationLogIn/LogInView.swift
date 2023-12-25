import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

@MainActor
final class AuthenticationViewModel: ObservableObject{
    
    private var currentNonce: String?
    @Published var didSingInWithApple: Bool = false
    let signInAppleHelper = SignInAppleHelper()
    
    func singInGoogle() async throws{
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthService.shared.signInWithGoogle(tokens: tokens)
    }
    func singInApple() async throws{
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        try await AuthService.shared.signInWithApple(tokens: tokens)
    }
}

struct LogInView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @State var email = ""
    @State var password = ""
    @State var isShowingRegisterView = false
    @State var isAuth = true
    @State var isShowAlert = false
    @State var alertMessage = ""
    @State var isShowContentView = false
    @State var isShowMapView = false
    
    var body: some View {
        ZStack{
           // BackgroundMain()
            Color(.white)
                .ignoresSafeArea()
            VStack{
                TextMain(text: "Travel Radar")
                    .padding(.top, 50)
                
                Button(action: {
                    Task{
                        do{
                            try await viewModel.singInApple()
                            isShowMapView.toggle()
                        }
                        catch{
                            alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                            self.isShowAlert.toggle()
                        }
                    }
                },label: {SignInWithAppleButtonViewRepresentable(type: .default, style: .whiteOutline)
                        .allowsHitTesting(false)
                }).frame(width: 300,height: 55)
                    //.padding(.bottom)
                
                Button(action: {
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
                }, label: {
                    ButtonRegisterImageView(imageName:"icons8-google",text: "Продолжить с Google")
                })
                //.frame(width: 300, height: 55)
                TextFieldMain(World: $email, placeholder: "Введите Email")
                PasswordFieldView(World: $password, placeholder: "Введите пароль")
                Button(action: {
                    Task{
                        do{
                            try await AuthService.shared.signInUser(email: email, password: password)
                            isShowMapView.toggle()
                        }
                        catch{
                            self.alertMessage = "Ошибка авторизации:\(error.localizedDescription)"
                            self.isShowAlert.toggle()
                        }
                    }
                }, label: {
                    ButtonEnter(text: "Войти", color: Color(.white))
                })
                Button(action: {
                    isShowingRegisterView.toggle()
                }, label: {
                    ButtonMini(text: "Создать учетную запись")
                })
                .alert(alertMessage, isPresented: $isShowAlert) {
                    Button{} label: {
                    }
                    Spacer()
                    
                }
                .fullScreenCover(isPresented: $isShowingRegisterView, content: {
                    RegisterChoiceView()
                })
                .fullScreenCover(isPresented: $isShowMapView, content: {MainAppView()
                })
            }
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
