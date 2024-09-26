//
//  SearchView.swift
//  IlaBankTask
//
//  Created by Neosoft on 30/08/24.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didUpdateSearchText(_ searchText: String, _ searchBar: UISearchBar)
}

class SearchView: UICollectionReusableView {
    
    weak var delegate: SearchViewDelegate?
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        let color = UIColor(resource: .appPink)
        searchBar.text = ""
        searchBar.barTintColor = UIColor.appBackground
        
        // Border
        searchBar.layer.cornerRadius = 10
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Search here", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        searchBar.searchTextField.textColor = color
        
        searchBar.showsCancelButton = true // show cancel button
        searchBar.searchTextField.leftView?.tintColor = color
        
        searchBar.searchTextField.rightView?.tintColor = .clear /// Hide dictation button
        searchBar.searchTextField.rightView?.isUserInteractionEnabled = false /// Disable interaction for mike button
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchBar.delegate = self
        
        addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 0),
            searchBar.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}

extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.didUpdateSearchText(searchText, searchBar)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        delegate?.didUpdateSearchText("", searchBar)
    }
    
}
