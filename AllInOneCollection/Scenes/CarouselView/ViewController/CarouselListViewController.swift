//
//  CarouselListViewController.swift
//  IlaBankTask
//
//  Created by Neosoft on 29/08/24.
//

import UIKit

class CarouselListViewController: UIViewController {
            
    @IBOutlet weak var clvCarouselList: UICollectionView!
    
    var viewModel: CarouselListDelegate
    var isSupplementaryViewLoaded = false
    
    init(viewModel: CarouselListDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollection()
        viewModel.fetchFinancialServices()
        viewModel.reloadServices(currentIndex: 0)
        view.addTapGesture {
            self.view.endEditing(true)
        }
    }
    
    private func registerCollection() {
        clvCarouselList.delegate = self
        clvCarouselList.dataSource = self
        clvCarouselList.collectionViewLayout = createGroupLayout()
        
        clvCarouselList.register(SearchView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifiers.search)
        clvCarouselList.register(PageControlView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CellIdentifiers.pageControl)
        
        clvCarouselList.register(UINib(nibName: CellIdentifiers.carousel, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.carousel)
        clvCarouselList.register(UINib(nibName: CellIdentifiers.carouselList, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.carouselList)
        clvCarouselList.register(UINib(nibName: CellIdentifiers.emptyView, bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.emptyView)
        
    }
    
}
