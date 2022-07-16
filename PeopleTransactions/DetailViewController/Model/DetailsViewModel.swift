//
//  DetailsViewModel.swift
//  PeopleTransactions
//
//  Created by Darsh on 15/07/22.
//

import RxSwift

internal final class DetailsViewModel {
    
    var model: TransactionsModel
    
    let cancel: PublishSubject<Void> = .init()
    
    init(model: TransactionsModel) {
        self.model = model
    }
}

extension DetailsViewModel: ViewModelProtocol {

   internal struct Input {
   }
   
   internal struct Output {
   }
       
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
    }
}
