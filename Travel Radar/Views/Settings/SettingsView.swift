import SwiftUI
import MapKit
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
    var body: some View {
        NavigationStack{
            List{
                if viewModel.authProviders.contains(.email){
                    EmailSection(isShowAlert: $isShowAlert, alertMessage: $alertMessage)
                }
                
                Button("Выбрать стиль карты") {
                    withAnimation{
                        isShowingStylePicker.toggle()
                    }
                }
                
                if isShowingStylePicker{
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
                }
                
                LogOut(isShowContentView: $isShowContentView, isShowAlert: $isShowAlert, alertMessage: $alertMessage)
                    .alert(alertMessage, isPresented: $isShowAlert) {
                        Button{} label: {
                        }
                    }
            }
            .padding(.top,50)
            
        }.onAppear{
            viewModel.loadAuthProviders()}
        //.navigationBarTitle("Настройки")
        .fullScreenCover(isPresented: $isShowMap, content: {MainAppView()})
        .fullScreenCover(isPresented: $isShowContentView, content: {LogInView()})
    }
}

#Preview
{
    SettingsView()
}
