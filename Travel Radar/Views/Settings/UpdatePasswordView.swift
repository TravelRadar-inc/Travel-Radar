import SwiftUI

struct UpdatePasswordView: View {
    @State var password = ""
    @StateObject private var viewModel1 = SignUpEmailInViewModel()
    @StateObject private var viewModel2 = SettingsViewModel()
    @State var confirmPassword = ""
    @State var isShowAlert = false
    @State var alertMessage = ""
    @State var isShowMainLogInView = false
    var body: some View {
            NavigationStack{
                VStack{
                    PasswordFieldView(World: $viewModel1.password, placeholder: "Введите новый пароль")
                    PasswordFieldView(World: $confirmPassword, placeholder: "Повторите пароль")
                    Button(action: {
                        guard viewModel1.password == confirmPassword else{
                            self.alertMessage = "Пароли не совпадают!"
                            self.isShowAlert.toggle()
                            return
                        }
                        Task{
                            do{
                                try await viewModel2.updatePassword(password: viewModel1.password)
                                Task{
                                    do{
                                        try viewModel2.signOut()
                                        isShowMainLogInView.toggle()
                                    }
                                    catch{
                                        self.alertMessage = "\(error.localizedDescription)"
                                        self.isShowAlert.toggle()
                                    }
                                }
                            }
                            catch{
                                self.alertMessage = "\(error.localizedDescription)"
                                self.isShowAlert.toggle()
                            }
                        }
                    }, label: {
                        ButtonEnter(text:"Изменить пароль", color: Color(.white))
                            .padding(.bottom,20)
                    })
                    .fullScreenCover(isPresented: $isShowMainLogInView, content: {
                        MainLogInView()
                    })
                    .alert(alertMessage, isPresented: $isShowAlert) {
                        Button{} label: {
                        }
                    }
                }
        }
    }
}

#Preview {
    UpdatePasswordView()
}
