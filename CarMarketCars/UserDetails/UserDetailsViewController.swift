import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class UserDetailsViewController: UIViewController {
    
    //MARK: - Fields
    
    var handle: AuthStateDidChangeListenerHandle?
    let carsdb = Firestore.firestore().collection(FirebaseCollectionNames.cars.rawValue)
    var carsList = [Car]()
    var searchingCarsList = [Car]()
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var UserImageImage: UIImageView!
    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var UserSurnameLbl: UILabel!
    @IBOutlet weak var UserEmailLbl: UILabel!
    @IBOutlet weak var UserUidLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Setup

    private func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        searchBar.delegate = self
    }

    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {        
        handle = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            
            let db = Firestore.firestore()
            let usersRef = db.collection(FirebaseCollectionNames.users.rawValue).document("\(auth.currentUser?.email ?? "")")
                        
            usersRef.getDocument { document, error in
                if let document = document {

                    guard let data = document.data() else { return }
                    let userData = User(with: data)
                    self?.UserNameLbl.text = userData.name
                    self?.UserSurnameLbl.text = userData.surname
                    self?.UserEmailLbl.text = userData.email
                    self?.UserUidLbl.text = userData.uid
                    
                    let currentUser = userData.email
                                        
                    self?.carsdb.whereField("Email", isEqualTo: currentUser).addSnapshotListener { snapshot, error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                        guard let snapshot = snapshot?.documents else { return }
                        
                        self?.carsList.removeAll()
                        
                        snapshot.forEach { document in
                            self?.carsList.append(Car(with: document.data()))
                        }
                        
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                        
                    }
                } else {
                    print("Document does'n exists \(error?.localizedDescription ?? "")")
                }
            }

            print("addStateDidChangeListener - UserDetailsViewController")
            
        })
            
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//
//        guard let handle = handle else { return }
//        Auth.auth().removeStateDidChangeListener(handle)
//        print("removeStateDidChangeListener - UserDetailsViewController")
//
//    }
    
}
