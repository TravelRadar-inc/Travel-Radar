import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct LogInView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @State var email = ""
    @State var password = ""
    @State var isShowingainLogInView = false
    @State var isAuth = true
    @State var isShowAlert = false
    @State var alertMessage = ""
    @State var isShowContentView = false
    @State var isShowMapView = false
    
    var body: some View {
        ZStack{
            VStack{
                Color(.white)
                    .ignoresSafeArea()
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
                    isShowingainLogInView.toggle()
                }, label: {
                    ButtonMini(text: "Создать учетную запись")
                })
                .alert(alertMessage, isPresented: $isShowAlert) {
                    Button{} label: {
                    }
                }
                .fullScreenCover(isPresented: $isShowingainLogInView, content: {
                    MainLogInView()
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
