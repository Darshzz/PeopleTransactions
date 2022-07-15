//
//  ViewController.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import UIKit
import RxSwift
import RxCocoa

class TransactionsViewController: ViewController<TransactionViewModel>, Storyboarded {

    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    
    let fetchData: PublishSubject<()> = .init()
    let selectItemEvent: PublishSubject<TransactionsModel> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOutput()
        fetchData.onNext(())
    }
    
    
    override func setupOutput() {
        super.setupOutput()
        
        let input = TransactionViewModel.Input(fetchSignal: fetchData.asObservable(), selectModelTapSignal: selectItemEvent, disposeBag: disposeBag)
          viewModel.transform(input, outputHandler: setupInput(input:))
      }
    
    override func setupInput(input: TransactionViewModel.Output) {
        super.setupInput(input: input)
        
        disposeBag.insert([
            setUpTableViewObserving(signal: input.updateTableViewSignal)
        ])
    }

    func setUpTableViewObserving(signal: Driver<[TransactionsModel]>) -> Disposable {
        signal
            .drive(with: self, onNext: { (`self`, result) in
                print(result)
                self.bindTableViewData(Observable.of(result))
            })
    }
    
    func bindTableViewData(_ result: Observable<[TransactionsModel]>) {
        _ = result.bind(to: tableView.rx.items(cellIdentifier: "TransactionTableCell", cellType: TransactionTableCell.self)) { ( row, model, cell) in
            cell.configureData(model: model)
         }
    }
}
