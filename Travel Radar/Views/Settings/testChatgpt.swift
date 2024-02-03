//import SwiftUI
//import MapKit
//
//struct testChatgpt: View {
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
//        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
//    )
//    @State private var mapType: MKMapType = .standard
//    
//    var body: some View {
//        VStack {
//            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .none, annotationItems: [], annotationContent: { _ in MapPin(coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), tint: .red) })
//                .frame(height: 300)
//                .mapType(mapType)
//            
//            HStack {
//                Button("Standard") {
//                    mapType = .standard
//                }
//                .buttonStyle(.bordered)
//
//                Button("Satellite") {
//                    mapType = .satellite
//                }
//                .buttonStyle(.bordered)
//
//                Button("Hybrid") {
//                    mapType = .hybrid
//                }
//                .buttonStyle(.bordered)
//            }
//        }
//    }
//}
//
//#Preview
//{
//    testChatgpt()
//}
//
