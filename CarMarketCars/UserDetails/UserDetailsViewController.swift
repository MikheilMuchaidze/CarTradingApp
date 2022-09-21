import UIKit

final class UserDetailsViewController: UIViewController {
    
    //MARK: - Fields
    
    var carsList = [Car]()
    var searchingCarsList = [Car]()
    
    //MARK: - Outlets
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userNameLbl: UILabel!
    @IBOutlet private weak var userSurnameLbl: UILabel!
    @IBOutlet private weak var userEmailLbl: UILabel!
    @IBOutlet private weak var userUidLbl: UILabel!
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
        fetchCarsByCurrentUserEmail()
    }
    
    //MARK: - Methods

    //fetching car data from database but for current email
    private func fetchCarsByCurrentUserEmail() {
        
        FirebaseDatabaseDownload.currentUserInfo(remove: false) { user in
            FirebaseDatabaseDownload.fetchCarsByEmail(email: user.email) { [weak self] snapshot, error in
                if let error = error {
                    self?.alertPopUp(title: AuthValidationAndAlert.ValidationTitles.fetchingCarsByEmailError, message: "\(error.localizedDescription)", okTitle: AuthValidationAndAlert.ValidationOkTitles.ok)
                } else {
                    let currentUserData = User(with: user.toDatabaseType())
                    self?.userNameLbl.text = currentUserData.name
                    self?.userSurnameLbl.text = currentUserData.surname
                    self?.userEmailLbl.text = currentUserData.email
                    self?.userUidLbl.text = currentUserData.uid
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
    
}
