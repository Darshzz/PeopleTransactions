//
//  TransactionViewModel.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import Foundation
import RxSwift

protocol TransactionViewModelPresentable {
    func fetchTransactions() -> Observable<[TransactionsModel]>
}

struct TransactionViewModel: TransactionViewModelPresentable {
//    var input: TransactionViewModelPresentable.Input
//    var output: TransactionViewModelPresentable.Output
    
    private var restClient: RestClient!
    private let disposeBag = DisposeBag()
    
//    init(input: TransactionViewModelPresentable.Input) {
//        self.input = input
//        self.output = TransactionViewModel.output(input: self.input)
//    }
    
    init(restClient: RestClient) {
        self.restClient = restClient
    }
    
    func fetchTransactions() -> Observable<[TransactionsModel]> {
        let observable: Observable<[TransactionsModel]> = restClient.apiRequest(APIRequest())
        return observable
    }
}

private extension TransactionViewModel {
    
//    static func output(input: TransactionViewModelPresentable.Input) -> TransactionViewModelPresentable.Output {
//        return ()
//    }
}
