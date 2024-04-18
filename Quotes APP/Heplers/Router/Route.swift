//
//  Route.swift
//  SwiftBoilerPlate
//
//  Created by AKASH BOGHANI on 10/03/24.
//

import UIKit

// MARK: - Route
enum Route {
    case main
    case success
    case home
    case profile
    case quotes(type: String)
}

extension Route {
    var viewController: UIViewController {
        switch self {
        case .main:
            guard let vc = R.storyboard.main.mainVc() else { return UIViewController() }
            return vc
        case .success:
            guard let vc = R.storyboard.main.successVc() else { return UIViewController() }
            return vc
        case .home:
            guard let vc = R.storyboard.main.homeVc() else { return UIViewController() }
            return vc
        case .profile:
            guard let vc = R.storyboard.main.profileVc() else { return UIViewController() }
            return vc
        case let .quotes(type):
            guard let vc = R.storyboard.main.quotesVc() else { return UIViewController() }
            vc.type = type
            return vc
        }
    }
}
