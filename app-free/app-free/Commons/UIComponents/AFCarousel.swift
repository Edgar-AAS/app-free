//
//  AFCarousel.swift
//  app-free
//
//  Created by Lidia on 07/11/25.
//

//
// AFCarousel.swift
//
import UIKit

class AFCarousel: UIView {
    
    var items: [UIView] = [] { didSet { reloadData() } }
    var visibleItemCount: Int = 3 { didSet { invalidateLayout() } }
    var itemSpacing: CGFloat = 16 {
        didSet { flowLayout.minimumLineSpacing = itemSpacing; invalidateLayout() }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = itemSpacing
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.decelerationRate = .fast
        cv.register(CarouselCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateItemSize()
    }
    
    private func updateItemSize() {
        guard bounds.width > 50 else { return }
        let totalSpacing = itemSpacing * CGFloat(visibleItemCount - 1)
        let itemWidth = (bounds.width - totalSpacing) / CGFloat(visibleItemCount)
        flowLayout.itemSize = CGSize(width: itemWidth, height: bounds.height)
    }
    
    private func invalidateLayout() { setNeedsLayout() }
    private func reloadData() { collectionView.reloadData(); setNeedsLayout() }
}

// MARK: - DataSource & Delegate
extension AFCarousel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CarouselCell
        cell.hostedView = items[indexPath.item]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let offset = scrollView.contentOffset.x
        
        for cell in collectionView.visibleCells {
            let centerX = cell.frame.midX
            let distance = abs(centerX - (offset + pageWidth / 2))
            let maxDistance = pageWidth / 2 + cell.frame.width / 2
            let phase = min(max(distance / maxDistance, 0), 1)
            
            let scale = 1.0 - 0.7 * phase
            let alpha = 1.0 - phase
            let offsetY = 50 * phase
            
            cell.alpha = alpha
            cell.transform = .init(scaleX: scale, y: scale).translatedBy(x: 0, y: offsetY)
        }
    }
}

class CarouselCell: UICollectionViewCell {
    var hostedView: UIView? {
        willSet { hostedView?.removeFromSuperview() }
        didSet {
            guard let view = hostedView else { return }
            contentView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: contentView.topAnchor),
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        transform = .identity
        alpha = 1
        hostedView = nil
    }
}
