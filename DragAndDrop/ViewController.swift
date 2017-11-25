import UIKit
import Anchors
import Omnia

// Drag from left to right for now
class ViewController: UIViewController, UICollectionViewDropDelegate, UICollectionViewDragDelegate {

  let leftController = CollectionController()
  let rightController = CollectionController()

  override func viewDidLoad() {
    super.viewDidLoad()

    [leftController, rightController].forEach {
      omnia_add(childController: $0)
      $0.collectionView.dragDelegate = self
      $0.collectionView.dropDelegate = self
    }

    leftController.cellColor = UIColor(hex: "#3498db")
    rightController.cellColor = UIColor(hex: "#2ecc71")

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

  // MARK: - UICollectionViewDragDelegate

  func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let controller = leftController

    let provider = NSItemProvider(
      object: controller.imageForCell(indexPath: indexPath)
    )

    let dragItem = UIDragItem(itemProvider: provider)
    dragItem.localObject = indexPath
    return [dragItem]
  }

  // MARK: - UICollectionViewDropDelegate

  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {

    let destinationIndexPath: IndexPath
    if let indexPath = coordinator.destinationIndexPath {
      destinationIndexPath = indexPath
    } else {
      destinationIndexPath = IndexPath(row: 0, section: 0)
    }

    let controller = rightController

    let dragItemIndexPath = coordinator.items.last?.dragItem.localObject as! IndexPath
    let draggedItem = leftController.items[dragItemIndexPath.item]

    // remove
    leftController.items.remove(at: dragItemIndexPath.item)
    leftController.collectionView.deleteItems(at: [dragItemIndexPath])

    // insert
    controller.items.insert(draggedItem, at: destinationIndexPath.item)
    controller.collectionView.insertItems(at: [destinationIndexPath])
  }
}
