//
//  NewsReponseModel.swift
//  BoilerPlate
//
//  Created by AKASH on 21/11/23.
//

import Foundation

// MARK: - ResponseModelElement
struct ResponseModelElement: Codable {
    let quote, author, category: String?
}
