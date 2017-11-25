import UIKit
import Anchors
import Omnia
import Dropdowns

class ViewController: UIViewController {

  let collectionController = CollectionController()

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
    let items = [
      "reset", "insert after", "insert before",
      "delete after", "delete before",
      "mix wrong", "mix right"
    ]
    let titleView = TitleView(
      navigationController: navigationController!,
      title: "home",
      items: items
    )

    titleView?.action = { [weak self] index in
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self?.handle(index: index)
      }
    }

    navigationItem.titleView = titleView
    reset()
  }

  // MARK: Logic

  func handle(index: Int) {
    switch index {
    case 0:
      self.reset()
    case 1:
      self.insertAfter()
    case 2:
      self.insertBefore()
    case 3:
      self.deleteAfter()
    case 4:
      self.deleteBefore()
    case 5:
      self.mixWrong()
    case 6:
      self.mixRight()
    default:
      break
    }
  }

  func reset() {
    collectionController.update(items: ["a", "b", "c", "d", "e", "f"])
  }

  func insertAfter() {
    collectionController.items.append(contentsOf: ["g", "h", "i"])
    let indexPaths = Array(6...8).map { IndexPath(item: $0, section: 0) }
    collectionController.collectionView.insertItems(at: indexPaths)
  }

  func insertBefore() {
    collectionController.items.insert("g", at: 0)
    collectionController.items.insert("h", at: 1)
    collectionController.items.insert("i", at: 2)

    let indexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
    collectionController.collectionView.insertItems(at: indexPaths)
  }

  func deleteAfter() {
    collectionController.items.removeLast()
    collectionController.items.removeLast()
    collectionController.items.removeLast()

    let indexPaths = Array(3...5).map { IndexPath(item: $0, section: 0) }
    collectionController.collectionView.deleteItems(at: indexPaths)
  }

  func deleteBefore() {
    collectionController.items.removeFirst()
    collectionController.items.removeFirst()
    collectionController.items.removeFirst()

    let indexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
    collectionController.collectionView.deleteItems(at: indexPaths)
  }

  func mixWrong() {

  }

  func mixRight() {

  }
}

