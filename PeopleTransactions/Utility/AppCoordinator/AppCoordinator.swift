//
//  AppCoordinator.swift
//  PeopleTransactions
//
//  Created by Darsh on 14/07/22.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    
    let window : UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() -> Observable<Void> {

        let navigationController = UINavigationController()
        let transactionCoordinator = TransactionsCoordinator(navigationController: navigationController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return self.coordinate(to: transactionCoordinator)
    }
}
