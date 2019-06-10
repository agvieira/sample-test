//
//  FindTwitterController.swift
//  IfoodMobileTest
//
//  Created by André Vieira on 09/06/19.
//  Copyright © 2019 André Vieira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class FindTwitterController: UIViewController {
    var findTwitterView: FindTwitterView
    var viewModel: FindTwitterViewModelOutput & FindTwitterViewModelInput
    
    private let bag = DisposeBag()
    
    init(viewModel: FindTwitterViewModelOutput & FindTwitterViewModelInput) {
        self.viewModel = viewModel
        findTwitterView = FindTwitterView()
        super.init(nibName: nil, bundle: nil)
        bindUserName()
        bindBtnFind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = findTwitterView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationbar()
    }
    
    private func setupNavigationbar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func bindBtnFind() {
        viewModel.isValidUser
            .bind(to: findTwitterView.btnFind.rx.isUserInteractionEnabled)
            .disposed(by: bag)
        
        findTwitterView.btnFind.rx.tap.subscribe(onNext: {[weak self] _ in
            self?.viewModel.findTweets()
        }).disposed(by: bag)
    }
    
    private func bindUserName() {
        findTwitterView.txtTwitter.rx.text.bind(to: viewModel.userName).disposed(by: bag)
    }
}
