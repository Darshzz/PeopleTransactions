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
        setUpDetailController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
        
        return Observable.never()
    }
    
    func setUpDetailController(viewModel: TransactionViewModel) {
        
        _ = viewModel.selectItemEvent
            .subscribe(onNext: { [weak self] model in
                self?.pushToDetailsController(model: model)
                    .subscribe()
                    .dispose()
            })
                .disposed(by: disposeBag)
    }
    
    func pushToDetailsController(model: TransactionsModel) -> Observable<DetailsCoordinationResult> {
        
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController)
        detailsCoordinator.model = model
        return self.coordinate(to: detailsCoordinator)
    }
}
