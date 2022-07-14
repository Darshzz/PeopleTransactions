//
//  DetailsCoordinator.swift
//  PeopleTransactions
//
//  Created by Darsh on 14/07/22.
//

import Foundation
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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start() -> Observable<CoordinationResult> {
        
        let viewController = DetailsViewController.instantiate()
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
        return .never()
    }
}
