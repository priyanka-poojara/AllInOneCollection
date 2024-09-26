//
//  PageControlView.swift
//  IlaBankTask
//
//  Created by Neosoft on 30/08/24.
//

import UIKit

protocol PageControlViewDelegate: AnyObject {
    func pageControlViewDidUpdatePage(to currentPage: Int, totalPageCount: Int)
}

class PageControlView: UICollectionReusableView, PageControlViewDelegate {
    
    private let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.currentPageIndicatorTintColor = .lightGray
        pageControl.backgroundColor = .clear
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    weak var delegate: PageControlViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(view)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            // Constraints for `view`
            view.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            view.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            view.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            
            // Constraints for `pageControl`
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20) // Adjust height as needed
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func pageControlViewDidUpdatePage(to currentPage: Int, totalPageCount: Int) {
        pageControl.numberOfPages = totalPageCount
        pageControl.currentPage = currentPage
    }
    
}
