import UIKit
import Anchors
import Omnia
import Dropdowns

class ViewController: UIViewController {

  let collectionController = CollectionController()
  lazy var items = Item.make(collectionController: collectionController)

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    omnia_add(childController: collectionController)
    activate(
      collectionController.view.anchor
        .edges.equal.to(view.safeAreaLayoutGuide.anchor)
        .insets(10)
    )

    collectionController.cellColor = UIColor(hex: "3498db")

    let titleView = TitleView(
      navigationController: navigationController!,
      title: "home",
      items: items.map({ $0.name })
    )

    titleView?.action = { [weak self] index in
      self?.handle(index: index)
    }

    navigationItem.titleView = titleView
    handle(index: 0)
  }

  // MARK: Logic

  func handle(index: Int) {
    let item = items[index]

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      item.action()
    }
  }
}

class Item {
  let name: String
  let action: () -> Void

  init(name: String, _ action: @escaping () -> Void) {
    self.name = name
    self.action = action
  }

  static func make(collectionController: CollectionController) -> [Item] {
    return [
      Item(name: "reset", {
        collectionController.update(items: ["a", "b", "c", "d", "e", "f"])
      }),
      Item(name: "insert 3 beginning", {
        collectionController.items.insert("g", at: 0)
        collectionController.items.insert("h", at: 1)
        collectionController.items.insert("i", at: 2)

        let indexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
        collectionController.collectionView.insertItems(at: indexPaths)
      }),
      Item(name: "delete 3 end", {
        collectionController.items.removeLast()
        collectionController.items.removeLast()
        collectionController.items.removeLast()

        let indexPaths = Array(3...5).map { IndexPath(item: $0, section: 0) }
        collectionController.collectionView.deleteItems(at: indexPaths)
      }),
      Item(name: "update at 2", {
        collectionController.items[2] = "👻"

        let indexPath = IndexPath(item: 2, section: 0)
        collectionController.collectionView.reloadItems(at: [indexPath])
      }),
      Item(name: "move c to end", {
        collectionController.items.remove(at: 2)
        collectionController.items.append("c")
        collectionController.collectionView.moveItem(
          at: IndexPath(item: 2, section: 0),
          to: IndexPath(item: 5, section :0)
        )
      }),
      Item(name: "delete 3 beginning, insert 3 end", {
        collectionController.items.removeFirst()
        collectionController.items.removeFirst()
        collectionController.items.removeFirst()

        collectionController.items.append(contentsOf: ["g", "h", "i"])

        collectionController.collectionView.performBatchUpdates({
          let deleteIndexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.deleteItems(at: deleteIndexPaths)

          let insertIndexPaths = Array(3...5).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.insertItems(at: insertIndexPaths)
        }, completion: nil)
      }),
      Item(name: "insert 3 end, delete 3 beginning", {
        collectionController.items.append(contentsOf: ["g", "h", "i"])

        collectionController.items.removeFirst()
        collectionController.items.removeFirst()
        collectionController.items.removeFirst()

        collectionController.collectionView.performBatchUpdates({
          let insertIndexPaths = Array(6...8).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.insertItems(at: insertIndexPaths)

          let deleteIndexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.deleteItems(at: deleteIndexPaths)
        }, completion: nil)
      }),
      Item(name: "insert 3 end, delete 3 beginning (😎)", {
        collectionController.items.append(contentsOf: ["g", "h", "i"])

        collectionController.items.removeFirst()
        collectionController.items.removeFirst()
        collectionController.items.removeFirst()

        collectionController.collectionView.performBatchUpdates({
          let deleteIndexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.deleteItems(at: deleteIndexPaths)

          let insertIndexPaths = Array(3...5).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.insertItems(at: insertIndexPaths)
        }, completion: nil)
      }),
      Item(name: "insert 3 end", {
        collectionController.items.append(contentsOf: ["g", "h", "i"])
        let indexPaths = Array(6...8).map { IndexPath(item: $0, section: 0) }
        collectionController.collectionView.insertItems(at: indexPaths)
      }),
      Item(name: "delete 3 end, insert 1 end", {
        collectionController.items.removeLast()
        collectionController.items.removeLast()
        collectionController.items.removeLast()

        collectionController.items.append(contentsOf: ["g"])

        collectionController.collectionView.performBatchUpdates({
          let indexPaths = Array(3...5).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.deleteItems(at: indexPaths)
          collectionController.collectionView.insertItems(at: [IndexPath(item: 3, section: 0)])
        }, completion: nil)
      }),
      Item(name: "delete 3 beginning, insert 1 beginning", {
        collectionController.items.removeFirst()
        collectionController.items.removeFirst()
        collectionController.items.removeFirst()

        collectionController.items.insert("g", at: 0)

        collectionController.collectionView.performBatchUpdates({
          let indexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.deleteItems(at: indexPaths)
          collectionController.collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
        }, completion: nil)
      }),
      Item(name: "delete 3 beginning, insert 1 end", {
        collectionController.items.removeFirst()
        collectionController.items.removeFirst()
        collectionController.items.removeFirst()

        collectionController.items.append("g")

        collectionController.collectionView.performBatchUpdates({
          let indexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.deleteItems(at: indexPaths)
          collectionController.collectionView.insertItems(at: [IndexPath(item: 3, section: 0)])
        }, completion: nil)
      }),
      Item(name: "insert 3 end, delete 1 end", {
        collectionController.items.append(contentsOf: ["g", "h", "i"])
        collectionController.items.removeLast()

        collectionController.collectionView.performBatchUpdates({
          collectionController.collectionView.deleteItems(at: [IndexPath(item: 5, section: 0)])

          let indexPaths = Array(5...7).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.insertItems(at: indexPaths)
        }, completion: nil)
      }),
      Item(name: "insert 3 beginning, delete 1 beginning", {
        collectionController.items.insert("g", at: 0)
        collectionController.items.insert("h", at: 1)
        collectionController.items.insert("i", at: 2)

        collectionController.items.removeFirst()

        collectionController.collectionView.performBatchUpdates({
          collectionController.collectionView.deleteItems(at: [IndexPath(item: 0, section: 0)])

          let indexPaths = Array(0...2).map { IndexPath(item: $0, section: 0) }
          collectionController.collectionView.insertItems(at: indexPaths)
        }, completion: nil)
      })
    ]
  }
}
