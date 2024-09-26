//
//  CarouseListModel.swift
//  IlaBankTask
//
//  Created by Neosoft on 30/08/24.
//

import Foundation

// MARK: JSON MODEL
 
struct FinancialServicesContainer: Decodable {
    let financialServices: [FinancialService]
    
    enum CodingKeys: String, CodingKey {
        case financialServices = "children_activities"
    }
}

struct FinancialService: Decodable, Identifiable {
    let id = UUID()
    let typeImage: String?
    let typeTitle: String?
    let listData: [ServiceDetail]?
    
    enum CodingKeys: String, CodingKey {
        case typeImage = "type_image"
        case typeTitle = "type_title"
        case listData = "listData"
    }
}

struct ServiceDetail: Decodable, Hashable {
    let image: String?
    let title: String?
    let subtitle: String?
}
