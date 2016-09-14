
import UIKit

class LapCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lapNumber: UILabel!
    @IBOutlet weak var lapTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
