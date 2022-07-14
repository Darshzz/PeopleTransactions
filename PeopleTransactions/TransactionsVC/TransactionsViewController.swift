//
//  ViewController.swift
//  PeopleTransactions
//
//  Created by Darsh on 13/07/22.
//

import UIKit
import RxDataSources

class TransactionsViewController: UIViewController, Storyboarded {

    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TransactionViewModelPresentable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let result = viewModel.fetchTransactions()
        _ = result.bind(to: tableView.rx.items(cellIdentifier: "TransactionTableCell", cellType: TransactionTableCell.self)) { ( row, model, cell) in
            cell.configureData(model: model)
         }
                
    }


}

