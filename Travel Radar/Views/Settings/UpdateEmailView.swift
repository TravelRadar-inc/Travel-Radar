import SwiftUI

struct UpdateEmailView: View {
    @State var email = ""
    @StateObject private var viewModel1 = SignUpEmailInViewModel()
    @StateObject private var viewModel2 = SettingsViewModel()
    @State var confirmEmail = ""
    @State var isShowAlert = false
    @State var alertMessage = ""
    @State var isShowMainLogInView = false
    var body: some View {
        NavigationStack{
            VStack{
                TextFieldMain(World: $viewModel1.email, placeholder: "Введите новый Email")
                TextFieldMain(World: $confirmEmail, placeholder: "Повторите Email")
                Button(action: {
                    guard viewModel1.email == confirmEmail else{
                        self.alertMessage = "Email не совпадают!"
                        self.isShowAlert.toggle()
                        return
                    }
                    print("OK")
                    Task{
                        do{
                            try await viewModel2.updateEmail(email: viewModel1.email)
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
                    ButtonEnter(text:"Изменить Email", color: Color(.white))
                        .padding(.bottom,20)
                })
            }.fullScreenCover(isPresented: $isShowMainLogInView, content: {
                MainLogInView()
            })
            .alert(alertMessage, isPresented: $isShowAlert) {
                Button{} label: {
                }
            }
        }
    }
}

#Preview {
    UpdateEmailView()
}
