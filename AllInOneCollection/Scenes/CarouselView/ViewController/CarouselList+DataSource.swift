//
//  CarouselList+DataSource.swift
//  IlaBankTask
//
//  Created by Neosoft on 29/08/24.
//

import UIKit

extension CarouselListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 2 // 1.Carousel, 2.Search & List
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.viewState.financialServices?.count ?? 0
        } else if section == 1 {
            return viewModel.viewState.serviceDetailList?.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0: 
            return configureCarouselCell(for: collectionView, indexPath: indexPath)
        case 1:
            return configureListOrEmptyCell(for: collectionView, indexPath: indexPath)
        default: return UICollectionViewCell()
        }
        
    }
    
    // Separate method for configuring carousel cells
    private func configureCarouselCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        // Attempt to dequeue the cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.carousel, for: indexPath) as? CarouselCell else {
            assertionFailure("Failed to dequeue CarouselCell")
            return UICollectionViewCell()
        }
        
        // Safely unwrap the data for the current index path
        guard let data = viewModel.viewState.financialServices?[indexPath.row] else {
            assertionFailure("No data available for indexPath: \(indexPath.row)")
            return cell // Return the cell anyway but without data
        }
        
        // Configure the cell with the data
        cell.setListData(data: data)
        
        return cell
    }

    // Separate method for configuring list or empty state cells
    private func configureListOrEmptyCell(for collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if let filteredData = viewModel.viewState.filteredServiceDetailList, !filteredData.isEmpty {
            // Dequeue and configure CarouselListCell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.carouselList, for: indexPath) as? CarouselListCell else {
                return UICollectionViewCell()
            }
            if let data = viewModel.viewState.serviceDetailList?[indexPath.row] {
                cell.setCarouselListData(data: data)
            }
            return cell
        } else {
            // Dequeue and return EmptyViewCell when no data is available
            guard let emptyCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.emptyView, for: indexPath) as? EmptyViewCell else {
                return UICollectionViewCell()
            }
            return emptyCell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellIdentifiers.search, for: indexPath) as? SearchView else { fatalError("SearchView") }
                
            print("Displaying header at \(indexPath.row)  \(indexPath.section)")
            headerView.delegate = self
            headerView.searchBar.text = ""
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellIdentifiers.pageControl, for: indexPath) as? PageControlView else { fatalError("PageControlView") }
            
            let currentIndex = viewModel.viewState.currentIndex
            if let pagesCount = viewModel.viewState.financialServices?.count {
                footerView.pageControlViewDidUpdatePage(to:  currentIndex, totalPageCount: pagesCount)
            }
            return footerView
            
        default:
            return UICollectionViewCell()
        }
    }
    
}
