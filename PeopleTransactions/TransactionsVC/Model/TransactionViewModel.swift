//
//  TransactionViewModel.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import Foundation
import RxSwift
import RxCocoa

internal final class TransactionViewModel {
    
    private var restClient: RestClient!
    private let disposeBag = DisposeBag()
    // Observer used to bind with api response
    let items: PublishRelay<[TransactionsModel]> = .init()
    // Input for item selected from table list
    var selectItemEvent: PublishSubject<TransactionsModel> = .init()
    
    init(restClient: RestClient) {
        self.restClient = restClient
        
        selectItemEvent.subscribe(onNext: {
            print($0)
        })
            .disposed(by: disposeBag)
    }
}

extension TransactionViewModel: ViewModelProtocol {

   internal struct Input {
       // Input for calling fetch api of list of transactions
       let fetchSignal: Observable<()>
       let disposeBag: DisposeBag
   }
   
   internal struct Output {
       let updateTableViewSignal: Driver<[TransactionsModel]>
       let selectModelTapSignal: PublishSubject<TransactionsModel>
   }
       
    func transform(_ input: Input, outputHandler: @escaping (Output) -> Void) {
        input.disposeBag.insert([setupFetchDataObserving(with: input.fetchSignal)])
        
        let output = Output(updateTableViewSignal: items.asDriver(onErrorJustReturn: []), selectModelTapSignal: selectItemEvent)
        outputHandler(output)
    }
    
    func setupFetchDataObserving(with signal: Observable<()>) -> Disposable {
        signal
            .flatMap({ [unowned self] (_) -> Observable<[TransactionsModel]> in
                self.restClient.apiRequest(APIRequest())
            })
            .bind(to: items)
    }
}
                            
