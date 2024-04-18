//
//  QuotesVm.swift
//  Quotes APP
//
//  Created by AKASH BOGHANI on 13/04/24.
//

import Foundation

final class QuotesVm: ViewModel {
    //MARK: - Properties
    private var disposeBag = Bag()
    private var taskBag = TaskBag()
    private var output = AppSubject<Output>()
    
    //MARK: - Enums
    enum Input {
        case getData(type: String)
    }
    
    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
        case getQuotes(data: ResponseModelElement?)
    }
    
    //MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case let .getData(type):
                strongSelf.getData(type: type)
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
    
    private func getData(type: String) {
        output.send(.loader(isLoading: true))
        Task {
            do {
                let model = try await networkServices.getData(type: type)
                output.send(.loader(isLoading: false))
                output.send(.getQuotes(data: model.first))
            } catch let error as APIError {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.description))
            } catch {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.localizedDescription))
            }
        }.store(in: &taskBag)
    }
}

