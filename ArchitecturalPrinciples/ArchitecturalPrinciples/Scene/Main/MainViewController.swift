//
//  MainViewController.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 15/09/2022.
//

import UIKit
import Combine

struct MainViewControllerActions {
    let showUIKit: () -> Void
}

class MainViewController: UIViewController {
    
    private var actions: MainViewControllerActions?
    
    static func create(actions: MainViewControllerActions) -> MainViewController {
        let view = MainViewController()
        view.actions = actions
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController {
    @IBAction func onClickUIKit(_ sender: Any) {
        actions?.showUIKit()
    }
    
    @IBAction func onClickSwiftUI(_ sender: Any) {
    }
}
