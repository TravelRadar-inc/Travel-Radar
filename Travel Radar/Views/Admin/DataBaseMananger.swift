import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class DataBaseMananger{
    static let shared = DataBaseMananger()
    let chatRef = Firestore.firestore().collection("chats")
    var chats = [Chat]()
    
    func creatNewChat(chat: Chat) async throws {
        let docRef = chatRef.document(chat.id)
        let data = ["id": chat.id,
                    "participant": chat.participant]
        as [String : Any]
        try await docRef.setData(data)
    }
    
    
    func fetchChats() async throws  -> [Chat]{
        let snapshot = try await chatRef.getDocuments()
        let strongSelf = self
        let chats = strongSelf.createChatsFromFirebaseSnapshot(snapshot: snapshot)
        //print(chats.count)
        return chats
    }
    
    func createChatsFromFirebaseSnapshot(snapshot: QuerySnapshot) -> [Chat]{
        let docs = snapshot.documents
        var chats = [Chat]()
        for doc in docs{
            let data = doc.data()
            let id = data["id"] as? String ?? "Error"
            let participant = data["participant"] as? Array ?? [""]
            let chat = Chat(id: id, participant: participant)
            chats.append(chat)
        }
        return chats
    }
    
    func fetchChat(chatId: String) async throws -> Chat{
        let snapshot = try await chatRef.document(chatId).getDocument()
        guard let data = snapshot.data(), let id = data["id"] as? String else{
            throw URLError(.badServerResponse)
        }
        let participant = data["participant"] as? Array ?? [""]
        return Chat(id: id, participant: participant)
    }
    
    func deleteChat(chatId:String) async throws{
        try await Firestore.firestore().collection("chats").document(chatId).delete()
    }
    
    func checkForMessages(chatId: String) async  -> Bool{
        do{
            let snapshot = try await chatRef.document(chatId).collection("messages").getDocuments()
            return !snapshot.isEmpty
        }catch{
            return false
        }
    }
    
}
