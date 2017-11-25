import UIKit
import Anchors

class Cell: UICollectionViewCell {
  let label = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    clipsToBounds = true
    layer.cornerRadius = 5

    label.font = UIFont.boldSystemFont(ofSize: 30)
    label.textColor = .black
    label.textAlignment = .center
    addSubview(label)

    activate(
      label.anchor.center
    )
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
