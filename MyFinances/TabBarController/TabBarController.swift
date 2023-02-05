//
//  TabBarController.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 2.02.23.
//

import UIKit

class TabBarController: UITabBarController {
    let dataSource = TabItem.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurateTabBar()
    }

    private func configurateTabBar() {
        var controllers: [UIViewController] = []
       
        dataSource.forEach { controller in
            controllers.append(controller.viewController)
        }
        viewControllers = controllers
        viewControllers?.enumerated().forEach({ index, controller in
            controller.tabBarItem = UITabBarItem(title: dataSource[index].rawValue, image: dataSource[index].iconImage, tag: dataSource[index].hashValue)
        })
    }
    
    private func hapticAlternative() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

