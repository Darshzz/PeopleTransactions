//
//  TransactionViewModel.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import Foundation
import RxSwift
import RxCocoa

struct TransactionViewModel {
    
    private var restClient: RestClient!
    private let disposeBag = DisposeBag()
    private let items: PublishRelay<[TransactionsModel]> = .init()
    
    init(restClient: RestClient) {
        self.restClient = restClient
    }
}

extension TransactionViewModel: ViewModelProtocol {

   internal struct Input {
       let fetchSignal: Observable<()>
       let selectModelTapSignal: Observable<TransactionsModel>
       let disposeBag: DisposeBag
   }
   
   internal struct Output {
       let updateTableViewSignal: Driver<[TransactionsModel]>
   }
       
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        input.disposeBag.insert([setupFetchDataObserving(with: input.fetchSignal)])
        let output = Output(updateTableViewSignal: items.asDriver(onErrorJustReturn: []))
        outputHandler(output)
    }
    
    func setupFetchDataObserving(with signal: Observable<()>) -> Disposable {
        signal
            .flatMap({ _ -> Observable<[TransactionsModel]> in
                restClient.apiRequest(APIRequest())
            })
            .bind(to: items)
    }
}
                            
