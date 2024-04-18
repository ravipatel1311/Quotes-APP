//
//  NetworkManager.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

final class NetworkManager: NetworkService {
    func getData(type: String) async throws -> [ResponseModelElement] {
        try await APIService.request(API.quotes(type: type))
    }
}
