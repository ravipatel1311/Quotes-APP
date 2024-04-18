//
//  QuotesVc.swift
//  Quotes APP
//
//  Created by AKASH BOGHANI on 13/04/24.
//

import UIKit

final class QuotesVc: ViewController<QuotesVm>{
    //MARK: - @IBOutlets
    @IBOutlet weak var lblQuotes: UILabel!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<QuotesVm.Input>()
    var type: String = "happiness"
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = QuotesVm()
        bindViewModel()
        input.send(.getData(type: type))
    }
    
    //MARK: - @IBActions
    @IBAction func didTapNextButton(_ sender: Any) {
        input.send(.getData(type: type))
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        viewModel?.router.pop(with: nil, for: nil)
    }
    
    //MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            case let .getQuotes(data):
                guard let data = data else { return }
                strongSelf.lblQuotes.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    strongSelf.lblQuotes.isHidden = false
                    strongSelf.lblQuotes.text = data.quote ?? ""
                }
            }
        }.store(in: &disposeBag)
    }
}
