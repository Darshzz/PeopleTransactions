//
//  ViewController.swift
//  PeopleTransactions
//
//  Created by Darsh on 15/07/22.
//

import UIKit
import RxSwift

public protocol ViewProtocol {
    associatedtype ViewModelType: ViewModelProtocol

    // swiftlint:disable:next implicitly_unwrapped_optional
    var viewModel: ViewModelType! { get set }

    func setupOutput()
    func setupInput(input: ViewModelType.Output)
}

open class ViewController<ViewModel: ViewModelProtocol>: UIViewController, ViewProtocol {
    
    // MARK: - Properties

    // swiftlint:disable:next implicitly_unwrapped_optional
    public var viewModel: ViewModel!

    // MARK: - Constructor

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
           super.init(coder: coder)
    }
    
    public func setupOutput() {
        
    }
    
    public func setupInput(input: ViewModel.Output) {
        
    }
}

fileprivate enum AssociatedKeys {
    static var disposeBag = "ViewController dispose bag associated key"
}

extension ViewController {

    public fileprivate(set) var disposeBag: DisposeBag {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBag, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            if let bag = objc_getAssociatedObject(self, &AssociatedKeys.disposeBag) as? DisposeBag {
                            return bag
            } else {
                let bag = DisposeBag()
                objc_setAssociatedObject(self, &AssociatedKeys.disposeBag, bag, .OBJC_ASSOCIATION_RETAIN)
                return bag
            }
        }
    }
}
