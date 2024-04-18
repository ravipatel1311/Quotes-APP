//
//  NetworkService.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

protocol NetworkService {
    func getData(type: String) async throws -> [ResponseModelElement]
}
