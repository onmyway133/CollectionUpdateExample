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
      "delete insert after", "delete insert before",
      "delete before insert after"
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
      reset()
    case 1:
      insertAfter()
    case 2:
      insertBefore()
    case 3:
      deleteAfter()
    case 4:
      deleteBefore()
    case 5:
      deleteInsertAfter()
    case 6:
      deleteInsertBefore()
    case 7:
      deleteBeforeInsertAfter()
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

  func deleteInsertAfter() {
    collectionController.items.removeLast()
    collectionController.items.removeLast()
    collectionController.items.removeLast()

    collectionController.items.append(contentsOf: ["g"])

    collectionController.collectionView.performBatchUpdates({
      let indexPaths = Array(3...5).map { IndexPath(item: $0, section: 0) }
      collectionController.collectionView.deleteItems(at: indexPaths)
      collectionController.collectionView.insertItems(at: [IndexPath(item: 3, section: 0)])
    }, completion: nil)
  }

  func deleteInsertBefore() {
    collectionController.items.removeFirst()
    collectionController.items.removeFirst()
    collectionController.items.removeFirst()

    collectionController.items.insert("g", at: 0)

    collectionController.collectionView.performBatchUpdates({
      let indexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
      collectionController.collectionView.deleteItems(at: indexPaths)
      collectionController.collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
    }, completion: nil)
  }

  func deleteBeforeInsertAfter() {
    collectionController.items.removeFirst()
    collectionController.items.removeFirst()
    collectionController.items.removeFirst()

    collectionController.items.append("g")

    collectionController.collectionView.performBatchUpdates({
      let indexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
      collectionController.collectionView.deleteItems(at: indexPaths)
      collectionController.collectionView.insertItems(at: [IndexPath(item: 3, section: 0)])
    }, completion: nil)
  }
}

