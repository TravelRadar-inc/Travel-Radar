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

struct RegisterChoiceView: View {
    @StateObject var viewModel = AuthenticationViewModel()
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
                    Task{
                        do{
                            try await viewModel.singInApple()
                        }
                        catch{
                            alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                            self.isShowAlert.toggle()
                        }
                    }
                },label: {SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                        .allowsHitTesting(false)
                })
                .frame(width: 300, height: 55)

//                Button(action: {
//                    
//                }, label: {
//                    ButtonRegisterImageView(imageName: "icons8-apple",
//                                       text: "Войти с помощью Apple   ")
//                })
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
                    ButtonRegisterImageView(imageName:"icons8-google",text: "Войти с помощью Google")
                })
                Spacer()
                Button(action: {
                    isShowingContentView.toggle()
                }, label: {
                    ButtonMini(text: "Уже есть аккаунт?")
                })
            }.fullScreenCover(isPresented: $isShowingRegister2View, content: {
                RegisterWindowView()})
            .fullScreenCover(isPresented: $isShowingContentView, content: {
               LogInView()})
            .fullScreenCover(isPresented: $isShowMapView, content: {
                MainAppView()
            .alert(alertMessage, isPresented: $isShowAlert) {
                Button{} label: {
                }
            }
            })
        }
    }
}

#Preview {
    RegisterChoiceView()
}

