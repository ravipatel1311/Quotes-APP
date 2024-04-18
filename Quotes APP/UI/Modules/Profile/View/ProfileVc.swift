//
//  ProfileVc.swift
//  NewsApp
//
//  Created by AKASH BOGHANI on 10/04/24.
//

import UIKit

final class ProfileVc: ViewController<ProfileVm> {
    //MARK: - @IBOutlets
    @IBOutlet weak var clvProfile: UICollectionView!
    
    //MARK: - Properties
    
    //MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProfileVm()
    }
    
    override func setUi() {
        super.setUi()
        
        clvProfile.delegate = self
        clvProfile.dataSource = self
        clvProfile.register(R.nib.profileCell)
        clvProfile.register(R.nib.dataCell)
        configureCollectionView()
    }
    
    //MARK: - @IBActions
    @IBAction func didTapButtonBack(_ sender: Any) {
        viewModel?.router.pop(with: nil, for: nil)
    }
    
    //MARK: - Functions
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return AppLayout.shared.profileSection()
            case 1: return AppLayout.shared.profileSection()
            default: return AppLayout.shared.profileSection()
            }
        }
        clvProfile.setCollectionViewLayout(layout, animated: true)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ProfileVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return QuoteCategories.allCases.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell: ProfileCell = clvProfile.deque(indexPath: indexPath)
            return cell
        case 1:
            let cell: DataCell = clvProfile.deque(indexPath: indexPath)
            let sortedArr = QuoteCategories.allCases.sorted(by: { $0.rawValue < $1.rawValue })
            cell.model = sortedArr[indexPath.row].rawValue.capitalized
            cell.viewBg.backgroundColor = .clear
            cell.viewBg.layer.borderColor = R.color.color_4E4B66()?.cgColor
            cell.viewBg.layer.borderWidth = 1
            cell.lblTitle.textColor = R.color.color_4E4B66()
            return cell
        default: return .init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sortedArr = QuoteCategories.allCases.sorted(by: { $0.rawValue < $1.rawValue })
        viewModel?.router.push(to: .quotes(type: sortedArr[indexPath.row].rawValue.capitalized), with: nil, for: nil)
    }
}
