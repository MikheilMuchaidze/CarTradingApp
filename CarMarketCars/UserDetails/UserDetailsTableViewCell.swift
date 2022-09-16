import UIKit

final class UserDetailsTableViewCell: UITableViewCell, LoadableView {
    
    //MARK: - Outlets
    
    @IBOutlet weak var helperView: UIView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carMarkLbl: UILabel!
    @IBOutlet weak var carModelLbl: UILabel!
    @IBOutlet weak var carYearLbl: UILabel!
    @IBOutlet weak var carLocationLbl: UILabel!
    @IBOutlet weak var carPriceLbl: UILabel!
    @IBOutlet weak var carPhoneLbl: UILabel!
    var loader = UIActivityIndicatorView()
    
    //MARK: - Cell Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Setup
    
    private func setup() {
        setupLoader()
        helperView.layer.cornerRadius = 10
        carImage.layer.cornerRadius = 10
        carImage.layer.borderColor = UIColor.systemBlue.cgColor
        carImage.layer.borderWidth = 2
        carImage.backgroundColor = .clear
        carImage.contentMode = .scaleAspectFill
    }
    
    func setupLoader() {
        carImage.addSubview(loader)
        loader.center(inView: carImage)
    }
    
}


