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
        let authDataResult = try await AuthService.shared.signInWithGoogle(tokens: tokens)
        try await UserMananger.shared.creatNewUser(auth: authDataResult)
    }
    func singInApple() async throws{
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthService.shared.signInWithApple(tokens: tokens)
        try await UserMananger.shared.creatNewUser(auth: authDataResult)
    }
}

struct MainLogInView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @State var email = ""
    @State var password = ""
    @State var isShowingRegisterChoiceView = false
    @State var isAuth = true
    @State var isShowAlert = false
    @State var alertMessage = ""
    @State var isShowContentView = false
    @State var isShowMapView = false
    @State var isShowLogInView = false
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(spacing: 16) {
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
                    },label: {SignInWithAppleButtonViewRepresentable(type: .default, style: .white)
                            .allowsHitTesting(false)
                    }).frame(width: 320,height: 55)
                        .cornerRadius(10)
                    
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
                    Button(action: {
                        isShowingRegisterChoiceView.toggle()
                    }, label: {
                        SignUpWithEmainBtn(text:"Регистрация с почтой", imageName: "envelope.fill")
                        
                    })
                    Button(action: {
                        isShowLogInView.toggle()
                    }, label: {
                        LogInBtn(text: "Войти")
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
            }
        }
        .fullScreenCover(isPresented: $isShowingRegisterChoiceView, content: {
            RegisterChoiceView()
        })
        .fullScreenCover(isPresented: $isShowMapView, content: {
            MainAppView()
        })
        .alert(alertMessage, isPresented: $isShowAlert) {
            Button{} label: {
            }
        }
        .fullScreenCover(isPresented: $isShowLogInView, content: {
            LogInView()
        })
    }
}

#Preview {
    MainLogInView()
}

