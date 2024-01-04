import SwiftUI
import Firebase
import FirebaseAuth
@main
struct Travel_RadarApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
//            if let user = Auth.auth().currentUser{
//                if user.uid == "mDMX2tTyvYfM8qtCRWdgaMaMa7l2" || user.uid == "Z9GVW4GMORPBPfQUOvX1UTarnl23"{
//                    AdminView()
//                } else{
//                    MainAppView()
//                }
//                
//            }
            MainAppView()
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate{
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

