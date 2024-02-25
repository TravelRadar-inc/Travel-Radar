import Foundation
struct DBUser{
    let userId: String
    let email: String?
    let photoURL: String?
    let name: String?
    let dateCreated: Date?
    
    func fetchPhotoURL()  -> URL? {
        guard let photoURLString = photoURL, let url = URL(string: photoURLString) else{
            return nil
        }
        return url
    }
}
