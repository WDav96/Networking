//
//  DateDecoder.swift
//  Networking
//
//  Created by Wilson David Molina Lozano on 18/08/22.
//

import Foundation

final class DateDecoder: JSONDecoder {
    
    // MARK: - Private Properties
    
    let dateFormatter = DateFormatter()
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        setupFormatter()
    }
    
    
    // MARK: - Private Methods
    
    private func setupFormatter() {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
