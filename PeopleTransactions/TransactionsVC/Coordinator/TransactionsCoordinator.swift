//
//  TransactionsCoordinator.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import RxSwift
import UIKit


class TransactionsCoordinator: BaseCoordinator<Void> {
    
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> Observable<CoordinationResult> {
        let viewModel = TransactionViewModel(restClient: RestClient())
        let viewController = TransactionsViewController.instantiate()
        
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
        
        return Observable.never()
    }
    
    func pushToDetailsController() -> Observable<DetailsCoordinationResult> {
        
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController)
        let viewController = DetailsViewController.instantiate()
        
        navigationController.pushViewController(viewController, animated: true)
        
        return self.coordinate(to: detailsCoordinator)
    }
}
