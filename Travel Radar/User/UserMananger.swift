import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class UserMananger{
     
    static let shared = UserMananger()
    
    func creatNewUser(auth: AuthDataResultModel) async throws{
        var userData: [String: Any] = [
            "id": auth.uid,
            "dateCreated": Timestamp()
        ]
        if let email = auth.email{
            userData["email"] = email
        }
        
        if let name = auth.name{
            userData["name"] = name
        }
        
        if let photoURL = auth.photoURL{
            userData["photoURL"] = photoURL
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData)
    }
    
    func fetchUser(userId: String) async throws -> DBUser{
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["id"] as? String  else{
            throw URLError(.badServerResponse)
        }
        let email = data["email"] as? String
        let photoURL = data["photoURL"] as? String
        let name = data["name"] as? String
        let dateCreated = data["dateCreated"] as? Date
        return DBUser(userId: userId, email: email, photoURL: photoURL, name: name, dateCreated: dateCreated)
    }
    
    func deleteUser(userId: String) async throws{
        try await Firestore.firestore().collection("users").document(userId).delete()
    }
}
