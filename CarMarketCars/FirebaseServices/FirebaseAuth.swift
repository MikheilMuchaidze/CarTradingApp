import FirebaseAuth

enum FirebaseAuth {
    
    //MARK: - Login service
    
    static func loginUser(withEmail email: String, password: String, completion: @escaping ((AuthDataResult?, Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    //MARK: - Register service
    
    static func registerUser(withEmail email: String, password: String, completion: @escaping ((AuthDataResult?, Error?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    //MARK: - Log out service
    
    static func logOutUser() {
        do {
            try Auth.auth().signOut()
            print("logged out")
        } catch let error {
            //TODO: - No error handling?????
            print(error.localizedDescription)
        }
    }
    
}
