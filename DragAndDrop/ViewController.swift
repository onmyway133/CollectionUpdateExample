import UIKit
import Anchors
import Omnia

class ViewController: UIViewController {

  let leftController = CollectionController()
  let rightController = CollectionController()

  override func viewDidLoad() {
    super.viewDidLoad()

    leftController.cellColor = UIColor(hex: "#3498db")
    omnia_add(chilController: leftController)

    rightController.cellColor = UIColor(hex: "#2ecc71")
    omnia_add(chilController: rightController)

    let centerXGuide = UILayoutGuide()
    view.addLayoutGuide(centerXGuide)

    activate(
      centerXGuide.anchor.centerX,

      leftController.view.anchor.top.left.constant(10),
      leftController.view.anchor.bottom.constant(-10),
      leftController.view.anchor.right.equal.to(centerXGuide.anchor.left).constant(-30),

      rightController.view.anchor.top.constant(10),
      rightController.view.anchor.right.bottom.constant(-10),
      rightController.view.anchor.left.equal.to(centerXGuide.anchor.right).constant(30)
    )

    leftController.update(items: Array(0..<100).map(String.init))
    rightController.update(items: Array(100..<200).map(String.init))
  }
}

