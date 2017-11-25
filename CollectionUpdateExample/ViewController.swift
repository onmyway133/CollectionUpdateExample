import UIKit
import Anchors
import Omnia
import Dropdowns

class ViewController: UIViewController {

  let collectionController = CollectionController()

  enum Action: Int {
    case reset
    case insert
    case delete
    case mixWrong
    case mixRight
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    omnia_add(childController: collectionController)
    activate(
      collectionController.view.anchor
        .edges.equal.to(view.safeAreaLayoutGuide.anchor)
        .insets(10)
    )

    collectionController.cellColor = UIColor(hex: "3498db")
    collectionController.update(items: Array(0..<100).map(String.init))

    // dropdown
    let items = ["reset", "insert", "delete", "mix wrong", "mix right"]
    let titleView = TitleView(
      navigationController: navigationController!,
      title: "home",
      items: items
    )

    titleView?.action = { [weak self] index in
      switch Action(rawValue: index)! {
      case .reset:
        self?.reset()
      case .insert:
        self?.insert()
      case .delete:
        self?.delete()
      case .mixWrong:
        self?.mixWrong()
      case .mixRight:
        self?.mixRight()
      }
    }

    navigationItem.titleView = titleView
    reset()
  }

  // MARK: Logic

  func reset() {
    collectionController.update(items: Array(0..<5).map(String.init))
  }

  func insert() {

  }

  func delete() {

  }

  func mixWrong() {

  }

  func mixRight() {

  }
}

