//
//  DetailsCoordinator.swift
//  PeopleTransactions
//
//  Created by Darsh on 14/07/22.
//

import RxSwift
import UIKit

/// Type that defines possible coordination results of the `DetailsCoordinationResult`.
///
/// - cancel: Cancel button was tapped.
enum DetailsCoordinationResult {
    case cancel
}

class DetailsCoordinator: BaseCoordinator<DetailsCoordinationResult> {
    
    var navigationController: UINavigationController!
    var model: TransactionsModel!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> Observable<CoordinationResult> {
        
        let viewModel = DetailsViewModel(model: model)
        let viewController = DetailsViewController.instantiate()
       
        viewController.viewModel = viewModel
        viewModel.cancel
            .subscribe(onNext: { [weak self] in
                self?.navigationController.popViewController(animated: true)
            })
            .disposed(by: viewController.disposeBag)
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
        return .never()
    }
}
