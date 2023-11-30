import SwiftUI
@MainActor
struct RegisterWindowView: View {
    @StateObject private var viewModel = SignUpEmailInViewModel()
    @State var isShowingContentView = false
    @State var confirmPassword = ""
    @State var isAuth = true
    @State var isShowAlert = false
    @State var alertMessage = ""
    var body: some View {
        ZStack{
            BackgroundMain()
            VStack{
                Spacer();
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
                        do {_ = try await AuthService.shared.createUser(email: viewModel.email, password: viewModel.password)
                            isShowingContentView.toggle()
                        } catch{
                            alertMessage = "Ошибка регистрации \(error.localizedDescription)"
                            self.isShowAlert.toggle()
                        }
                    }
                }, label: {
                    ButtonEnter(text:"Зарегестрироваться", color: Color("prosrachniiBerusovii"))
                        .padding(.bottom)
                })
                Spacer()
                Button(action: {
                    isShowingContentView.toggle()
                }, label: {
                    ButtonMini(text: "Уже есть аккаунт?")
                })
                .alert(alertMessage, isPresented: $isShowAlert) {
                    Button{} label: {
                    }
                }
            }
        }.fullScreenCover(isPresented: $isShowingContentView, content: {
            LogInView()})
    }
}

#Preview {
    RegisterWindowView()
}
