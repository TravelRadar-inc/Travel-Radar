import SwiftUI
struct LogInView: View {
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
            BackgroundMain()
            VStack{
                TextMain(text: "Travel Radar")
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
                    ButtonEnter(text: "Войти", color: Color("prosrachniiBerusovii"))
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
