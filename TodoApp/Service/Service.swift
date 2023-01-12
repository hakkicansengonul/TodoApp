//
//  Service.swift
//  TodoApp
//
//  Created by hakkı can şengönül on 10.01.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
struct Service {
    
    static func sendTask(text: String, completion: @escaping(Error?)-> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let taskId = NSUUID().uuidString
        let data = [
            "text": text,
            "timestamp": Timestamp(date: Date()),
            "taskId": taskId
        ] as [String: Any]
        Firestore.firestore().collection("tasks").document(currentUid).collection("continue").document(taskId).setData(data,completion: completion)  
    }
    
    static func fetchUser(uid: String, completion: @escaping(User)-> Void){
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else{ return }
            let user = User(data: data)
            completion(user)
        }
        
        
    }
}
