//
//  TabItem.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 2.02.23.
//

import Foundation
import UIKit

enum TabItem: String, CaseIterable {
    case finance = "Финансы"
    case changeFinance = "Добавить"
    case statistic = "Статистика"

    var viewController: UIViewController {
        switch self {
            case .finance:
                let vc = FinanceViewController(nibName: String(describing: FinanceViewController.self), bundle: nil)
                return self.wrappedInNavigationController(with: vc)
            case .changeFinance:
                let vc = ChangeFInanceViewController(nibName: String(describing: ChangeFInanceViewController.self), bundle: nil)
                return self.wrappedInNavigationController(with: vc)
            case .statistic:
                let vc = StatisticsFinansViewController(nibName: String(describing: StatisticsFinansViewController.self), bundle: nil)
                return self.wrappedInNavigationController(with: vc)
        }
    }
    
    var iconImage: UIImage {
        switch self {
            case .finance:
                return UIImage(systemName: "dollarsign.circle")!
            case .changeFinance:
                return UIImage(systemName: "dollarsign.arrow.circlepath")!
            case .statistic:
                return UIImage(systemName: "chart.bar.xaxis")!
        }
    }
    
    private func wrappedInNavigationController(with: UIViewController) -> UINavigationController {
         UINavigationController(rootViewController: with)
    }
}
