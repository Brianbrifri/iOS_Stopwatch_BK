
import UIKit

class LapCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lapNumber: UILabel!
    @IBOutlet weak var lapTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
