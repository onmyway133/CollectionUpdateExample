import UIKit
import Anchors
import Omnia

class ViewController: UIViewController {

  let collectionController = CollectionController()

  override func viewDidLoad() {
    super.viewDidLoad()

    omnia_add(chilController: collectionController)
    activate(
      collectionController.view.anchor
        .edges.equal.to(view.safeAreaLayoutGuide.anchor)
        .insets(10)
    )

    collectionController.cellColor = UIColor(hex: "3498db")
    collectionController.update(items: Array(0..<100).map(String.init))
  }
}

