//
//  JsonFileLoader.swift
//  IlaBankTask
//
//  Created by Neosoft on 02/09/24.
//

import Foundation

protocol DataLoader {
    func load<T: Decodable>(from file: String, withExtension fileExtension: FileType) throws -> T
}

final class JSONFileLoader: DataLoader {
    
    // MARK: - Loading data from a local file
    func load<T: Decodable>(from file: String, withExtension fileExtension: FileType) throws -> T {
        guard let fileURL = Bundle.main.url(forResource: file, withExtension: fileExtension.rawValue) else {
            throw FileLoaderError.invalidFilePath
        }
        
        let fileData = try Data(contentsOf: fileURL)
        let decodedData = try JSONDecoder().decode(T.self, from: fileData)
        
        return decodedData
    }
}

enum FileLoaderError: LocalizedError {
    case invalidFilePath
    
    var errorDescription: String? {
        switch self {
        case .invalidFilePath:
            return "The specified file path is invalid."
        }
    }
}

enum FileType: String {
    case json
}
