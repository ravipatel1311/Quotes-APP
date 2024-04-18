//
//  HomeVc.swift
//  NewsApp
//
//  Created by AKASH BOGHANI on 10/04/24.
//

import UIKit

final class HomeVc: ViewController<HomeVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvHome: UICollectionView!
    
    //MARK: - Properties
    private var disposeBag = Bag()
    private var input = AppSubject<HomeVm.Input>()
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeVm()
        bindViewModel()
    }
    
    override func setUi() {
        super.setUi()
        
        clvHome.delegate = self
        clvHome.dataSource = self
        clvHome.register(R.nib.dataCell)
        configureCollectionView()
    }
    
    //MARK: - @IBActions
    @IBAction func didTapButtonSetting(_ sender: Any) {
        viewModel?.router.push(to: .profile, with: nil, for: nil)
    }
    
    //MARK: - Functions
    private func bindViewModel() {
        viewModel?.transform(input: input.eraseToAnyPublisher()).weekSink(self) { strongSelf, event in
            switch event {
            case let .loader(isLoading):
                isLoading ? strongSelf.showHUD() : strongSelf.hideHUD()
            case let .showError(msg):
                strongSelf.showAlert(msg: msg)
            }
        }.store(in: &disposeBag)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return AppLayout.shared.tagSection()
        }
        clvHome.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QuoteCategories.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DataCell = clvHome.deque(indexPath: indexPath)
        let sortedArr = QuoteCategories.allCases.sorted(by: { $0.rawValue < $1.rawValue })
        cell.model = sortedArr[indexPath.row].rawValue.capitalized
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sortedArr = QuoteCategories.allCases.sorted(by: { $0.rawValue < $1.rawValue })
        viewModel?.router.push(to: .quotes(type: sortedArr[indexPath.row].rawValue.capitalized), with: nil, for: nil)
    }
}

enum QuoteCategories: String, CaseIterable {
    case age, alone, amazing, anger, architecture, art, attitude, beauty, best, birthday
    case business, freedom, friendship, funny, future, god, good, government, graduation
    case car, great, happiness, health, history, home, hope, humor, imagination, inspirational
    case change, intelligence, jealousy, knowledge, leadership, learning, legal, life, love
    case communication, marriage, medical, men, mom, money, morning, movies, success, forgiveness
    case computers, food, fitness, fear, famous, family, faith, failure, experience, equality
    case cool, environmental, education, dreams, design, death, dating, dad, courage
}
