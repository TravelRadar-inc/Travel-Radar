import SwiftUI
import Firebase
final class UpdateUserInfoViewModel: ObservableObject{
    func updateName(name: String) async throws{
        if let authUser = Auth.auth().currentUser{
            try await UserMananger.shared.updateName(userId: authUser.uid, name: name)
        }
        else{
            throw URLError(.badServerResponse)
        }
    }
    
    func updatePhoto(photoURL:String) async throws{
        if let authUser = Auth.auth().currentUser{
            try await UserMananger.shared.updateName(userId: authUser.uid, name: photoURL)
        }else{
            throw URLError(.badServerResponse)
        }
    }
}

struct UpdateUserInfo: View {
    @StateObject var viewModel = UpdateUserInfoViewModel()
    @State var name = ""
    @State var photoURL = ""
    @State var isShowAlert = false
    @State var alertMessage = ""
    var body: some View {
        NavigationStack{
            VStack{
                TextFieldMain(World: $name, placeholder: "Введите имя..." )
                //TextFieldMain(World: $photoURL, placeholder: "Вставьте URL фотографии" )
                Button(action: {
                    Task{
                        do{
                            if name != ""{
                                try await viewModel.updateName(name: name)
                                self.alertMessage = "Информация обновлена"
                                self.isShowAlert.toggle()
                            }
                            if photoURL != ""{
                                try await viewModel.updatePhoto(photoURL: photoURL)
                                self.alertMessage = "Информация обновлена"
                                self.isShowAlert.toggle()
                            }
                            if photoURL == "" && name == ""{
                                self.alertMessage = "Оба поля пустые"
                                self.isShowAlert.toggle()
                            }
                        }
                    }
                }, label: {
                    ButtonEnter(text: "Сохранить", color: Color(.white))
                })
            }
        }.alert(alertMessage, isPresented: $isShowAlert) {
            Button{} label: {
            }
        }
    }
}

#Preview {
    UpdateUserInfo()
}
