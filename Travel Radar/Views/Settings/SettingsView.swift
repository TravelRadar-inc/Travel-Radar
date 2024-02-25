import SwiftUI
import MapKit
import Firebase
@MainActor

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State var isShowMap = false
    @State var isShowContentView = false
    @State var isShowAlert = false
    @State var isShowingStylePicker = false
    @State var alertMessage = ""
    @State var check = false
    @State var styleOfMap: MapStyle = .standard
    @State var frame1color: Color = .blue
    @State var frame2color: Color = .black
//    @State var mapType: MKMapType = .standard
    var body: some View {
        NavigationStack{
            List{
                if viewModel.authProviders.contains(.email){
                    EmailSection(isShowAlert: $isShowAlert, alertMessage: $alertMessage)
                }
                Section{
                    HStack{
                        Button(action: {
                            styleOfMap = .standard
                            frame1color = .blue
                            frame2color = .gray
                        }, label: {
                            VStack {
                                Text("Стандартный")
                                    .foregroundColor(.black)
                                
                                Image("StandardMapStyle")
                                    .resizable()
                                    .frame(width: 110, height: 60)
                                    .cornerRadius(10)
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(frame1color, lineWidth: 2)
                            )
                        })
                        .padding(5)
                        
                        Spacer()
                        
                        Button(action: {
                            styleOfMap = .hybrid
                            frame1color = .gray
                            frame2color = .blue
                        }, label: {
                            VStack {
                                Text("Спутниковый")
                                    .foregroundColor(.black)
                                
                                Image("SatelliteMapStyle")
                                    .resizable()
                                    .frame(width: 110, height: 60)
                                    .cornerRadius(10)
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(frame2color, lineWidth: 2)
                            )
                        })
                        .padding(5)
                    }
                } header: {
                    Text("Стиль карты")
                }
                if let user = Auth.auth().currentUser{
                    if user.uid != "M0utShwhVqgrtBI2TI2yKo0eNfR2" && user.uid != "Z9GVW4GMORPBPfQUOvX1UTarnl23"{
                        TechnicalSupportView()
                    }else{}
                }
                
                LogOut(isShowContentView: $isShowContentView, isShowAlert: $isShowAlert, alertMessage: $alertMessage)
                DeleteAccount(isShowContentView: $isShowContentView, isShowAlert: $isShowAlert, alertMessage: $alertMessage)
            }
            .padding(.top,50)
            
        }.onAppear{
            viewModel.loadAuthProviders()}
        .fullScreenCover(isPresented: $isShowMap, content: {MainAppView()})
        .fullScreenCover(isPresented: $isShowContentView, content: {MainLogInView()})
    }
}

#Preview
{
    SettingsView()
}




//                Button("Выбрать стиль карты") {
//                    withAnimation{
//                        isShowingStylePicker.toggle()
//                    }
//                }
//
//                if isShowingStylePicker{
//                    HStack{
//                            Button(action: {
//                                styleOfMap = .standard
//                                frame1color = .blue
//                                frame2color = .gray
//                            }, label: {
//                                VStack {
//                                    Text("Стандартный")
//                                        .foregroundColor(.black)
//
//                                    Image("StandardMapStyle")
//                                        .resizable()
//                                        .frame(width: 110, height: 60)
//                                        .cornerRadius(10)
//                                }
//                                .padding(10)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(frame1color, lineWidth: 2)
//                                )
//                            })
//                            .padding(5)
//
//                        Spacer()
//
//                            Button(action: {
//                                styleOfMap = .hybrid
//                                frame1color = .gray
//                                frame2color = .blue
//                            }, label: {
//                                VStack {
//                                    Text("Спутниковый")
//                                        .foregroundColor(.black)
//
//                                    Image("SatelliteMapStyle")
//                                        .resizable()
//                                        .frame(width: 110, height: 60)
//                                        .cornerRadius(10)
//                                }
//                                .padding(10)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .stroke(frame2color, lineWidth: 2)
//                                )
//                            })
//                            .padding(5)
//                    }
//                }

