import SwiftUI

struct TestLogInView: View {
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
                        
                    }, label: {
                        SignUpWithEmainBtn(text:"Регистрация с почтой", imageName: "envelope.fill")
                        
                    })
                    Button(action: {
                        
                    }, label: {
                        LogInBtn(text: "Войти")
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
            }
        }
    }
}

#Preview {
    TestLogInView()
}

