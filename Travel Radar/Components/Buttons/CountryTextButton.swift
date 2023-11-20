import SwiftUI
import Foundation
import MapKit
struct CountryTextButton: View {
    @StateObject private var viewModel = MapViewModelView()
    //@State var countryName : String
    @State var countryImage: String
    //@State var view: any View
    var body: some View {
//        NavigationStack{
//            Map{
//                Annotation("",
//                           coordinate: viewModel.location[countryName]!) {
//                    NavigationLink{
//                        AnyView(view)
//                    } label: {
                        Image(countryImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22)
                            .cornerRadius(50)
                            .padding(5)
                            .background(Color(.white))
                            .cornerRadius(16)
                    }
                }
//            }
//        }
//    }
//}
//
//
