import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

@MainActor
struct RegisterChoiceView: View {
    @State var isShowingMainLogInView = false
    @State var isShowingLogInView = false
    @StateObject private var viewModel = SignUpEmailInViewModel()
    @State var confirmPassword = ""
    @State var isShowAlert = false
    @State var alertMessage = ""
    var body: some View {
        ZStack{
            VStack{
                TextRedisterView(text: "Хотите легко путешествовать?")
                    .padding(.top,10)
                TextRedisterView(text: "Присоединяйтесь к нам")
                    .padding(.bottom, 300)
                Spacer()
                TextFieldMain(World: $viewModel.email, placeholder: "Введите Email")
                PasswordFieldView(World: $viewModel.password, placeholder: "Введите пароль")
                PasswordFieldView(World: $confirmPassword, placeholder: "Повторите пароль")
                Button(action: {
                    guard viewModel.password == confirmPassword else{
                        self.alertMessage = "Пароли не совпадают!"
                        self.isShowAlert.toggle()
                        return
                    }
                    Task{
                        do { let authDataResult = try await AuthService.shared.createUser(email: viewModel.email, password: viewModel.password)
                            isShowingLogInView.toggle()
                            try await UserMananger.shared.creatNewUser(auth: authDataResult)
                        } catch{
                            alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                            self.isShowAlert.toggle()
                        }
                    }
                }, label: {
                    ButtonEnter(text:"Зарегестрироваться", color: Color(.white))
                        .padding(.bottom,20)
                })
                Spacer()
                Button(action: {
                    isShowingMainLogInView.toggle()
                }, label: {
                    ButtonMini(text: "Уже есть аккаунт?")
                })
                .fullScreenCover(isPresented: $isShowingMainLogInView, content: {
                    MainLogInView()})
                .alert(alertMessage, isPresented: $isShowAlert) {
                    Button{} label: {
                    }
                }
                .fullScreenCover(isPresented: $isShowingLogInView, content: {
                    LogInView()
                })
            }
        }
    }
}
#Preview {
    RegisterChoiceView()
}

