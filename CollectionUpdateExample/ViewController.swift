import UIKit
import Anchors
import Omnia
import Dropdown

class ViewController: UIViewController {

  let collectionController = CollectionController()

  enum Action: Int {
    case home
    case insert
    case delete
    case mixWrong
    case mixRight
  }

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

    // dropdown
    let items = ["home", "insert", "delete", "mix wrong", "mix right"]
    let titleView = TitleView(
      navigationController: navigationController!,
      title: "home",
      items: items
    )

    titleView?.action = { [weak self] index in
      switch Action(rawValue: index)! {
      case .home:
        self?.home()
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
  }

  // MARK: Logic

  func home() {
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

