//
//  CarouselList+Delegate.swift
//  IlaBankTask
//
//  Created by Neosoft on 29/08/24.
//

import UIKit

extension CarouselListViewController: UICollectionViewDelegate {
    
    func createGroupLayout() -> UICollectionViewLayout {
        return carouselListLayout()
    }
    
    private func carouselListLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0: return self.createCarouselSection()
            case 1: return self.createCarouselListSection()
            default: return nil
            }
        }
        
    }
    
    // Carousel List Sizing
    private func createCarouselSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(450))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        section.boundarySupplementaryItems = [createFooter()]
        section.interGroupSpacing = 0
        
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, point, env in
            guard let self = self else { return }
                updatePageControlAndReloadData(withVisibleItems: visibleItems, point: point)
        }
        
        return section
    }
    
    // Carousel Services List Sizing
    private func createCarouselListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.boundarySupplementaryItems = [createHeader()]
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 10, trailing: 0)
        return section
    }
    
    // Footer Sizing
    private func createFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
    }
    
    // Header Sizing
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        header.pinToVisibleBounds = true
        return header
    }
    
    // Update carousel state & Page Control
    func updatePageControlAndReloadData(
        withVisibleItems visibleItems: [NSCollectionLayoutVisibleItem],
        point: CGPoint
    ) {
        guard let lastVisibleItem = visibleItems.last else { return }

        let currentIndexPath = lastVisibleItem.indexPath
        
        if viewModel.viewState.currentIndex != currentIndexPath.row && point.y <= 0 {
            // Update the page control in the footer view
            if let financialServices = viewModel.viewState.financialServices,
               let collectionView = self.clvCarouselList,
               let footerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: 0)) as? PageControlView {
                
                let totalPages = financialServices.count
                footerView.pageControlViewDidUpdatePage(to: currentIndexPath.row, totalPageCount: totalPages)
                
                // Reload data only when the index changes
                viewModel.reloadServices(currentIndex: currentIndexPath.row)
                title = viewModel.viewState.currentServiceTitle
                
                DispatchQueue.main.async {
                    collectionView.reloadSections(IndexSet(integer: 1))
                }
            }
        }
    }
}

// MARK: Search View Delegate
extension CarouselListViewController: SearchViewDelegate {
    
    /// Section items alone can not reload due to that delete filtered items and inserted items
    func didUpdateSearchText(_ searchText: String, _ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let collectionView = clvCarouselList else { return }
        
        let sectionIndex = 1 // Assuming list in first section in accordance to current data

        /// **Removing existing list and deleting all items from collection
        let numberOfItemsBeforeUpdate = viewModel.viewState.serviceDetailList?.count ?? 0
        let indexPathsToDelete = (0..<numberOfItemsBeforeUpdate).map { IndexPath(item: $0, section: sectionIndex) }
        viewModel.viewState.serviceDetailList = nil
        collectionView.deleteItems(at: indexPathsToDelete)
        self.viewModel.seachServices(searchText: searchText)
        
        /// **Updating filtered search list and inserting new available data
        let updatedItemCount = viewModel.viewState.serviceDetailList?.count ?? 0
        let newIndexPaths = (0..<updatedItemCount).map { IndexPath(item: $0, section: sectionIndex) }

        DispatchQueue.main.async {
            collectionView.insertItems(at: newIndexPaths)
        }
        searchBar.becomeFirstResponder()
    }
    
}
