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
        
        let input = TransactionViewModel.Input(fetchSignal: fetchData.asObservable(), disposeBag: disposeBag)
          viewModel.transform(input, outputHandler: setupInput(input:))
      }
    
    override func setupInput(input: TransactionViewModel.Output) {
        super.setupInput(input: input)
        
        disposeBag.insert([
            setUpTableViewObserving(signal: input.updateTableViewSignal),
            setUpTableViewItemSelect(signal: input.selectModelTapSignal)
        ])
    }

    func setUpTableViewObserving(signal: Driver<[TransactionsModel]>) -> Disposable {
        signal
            .drive(with: self, onNext: { (`self`, result) in
                print(result)
                self.bindTableViewData(Observable.of(result))
            })
    }
    
    func setUpTableViewItemSelect(signal: PublishSubject<TransactionsModel>) -> Disposable {
        
        tableView.rx.modelSelected(TransactionsModel.self)
                .subscribe(onNext: { model in
                    signal.onNext(model)
                    
                    // Just to remove greyed out selected cell color after selection of item.
                    if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                      self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                    }
                })
    }
    
    func bindTableViewData(_ result: Observable<[TransactionsModel]>) {
       
        _ = result.bind(to: tableView.rx.items(cellIdentifier: "TransactionTableCell", cellType: TransactionTableCell.self)) { ( row, model, cell) in
            cell.configureData(model: model)
        }
        .disposed(by: disposeBag)
    }
}
