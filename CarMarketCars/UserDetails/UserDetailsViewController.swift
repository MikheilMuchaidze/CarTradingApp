import UIKit

final class UserDetailsViewController: UIViewController {
    
    //MARK: - Fields
    
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
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Setup

    private func setup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        searchBar.delegate = self
        
        FirebaseDatabaseDownload.currentUserInfo { user in
            FirebaseDatabaseDownload.fetchCarsByEmail(email: user.email) { [weak self] snapshot, error in
                let currentUserData = User(with: user.toDatabaseType())
                
                self?.UserNameLbl.text = currentUserData.name
                self?.UserSurnameLbl.text = currentUserData.surname
                self?.UserEmailLbl.text = currentUserData.email
                self?.UserUidLbl.text = currentUserData.uid
                
                guard let snapshot = snapshot?.documents else { return }
                self?.carsList.removeAll()
                snapshot.forEach { elem in
                    self?.carsList.append(Car(with: elem.data()))
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

}
