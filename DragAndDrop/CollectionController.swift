import UIKit
import Anchors

class CollectionController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  var items: [String] = []
  var cellColor: UIColor?
  var collectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()

    let layout = UICollectionViewFlowLayout()
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
    collectionView.dataSource = self
    collectionView.delegate = self

    collectionView.backgroundColor = .white

    view.addSubview(collectionView)
    activate(
      collectionView.anchor.edges
    )
  }

  // MARK: - Logic

  func update(items: [String]) {
    self.items = items
    collectionView.reloadData()
  }

  func imageForCell(indexPath: IndexPath) -> UIImage {
    let cell = collectionView.cellForItem(at: indexPath)!
    let render = UIGraphicsImageRenderer(size: cell.frame.size)
    return render.image(actions: { (context) in
      cell.drawHierarchy(in: cell.frame, afterScreenUpdates: false)
    })
  }

  // MARK: - UICollectionViewDataSource

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = items[indexPath.item]
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "Cell",
      for: indexPath
    ) as! Cell

    cell.backgroundColor = cellColor
    cell.label.text = item

    return cell
  }

  // MARK: - UICollectionViewDelegateFlowLayout

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize {

    let value = collectionView.frame.size.width / 3 - 12
    return CGSize(width: value, height: value)
  }
}
