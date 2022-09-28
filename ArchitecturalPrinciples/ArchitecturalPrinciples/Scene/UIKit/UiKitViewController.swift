//
//  UiKitViewController.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 28/09/2022.
//

import UIKit

class UiKitViewController: UIViewController {
    
    private var viewModel: UIKitViewModel!
    
    static func create(with viewModel: UIKitViewModel) -> UiKitViewController {
        let view = UiKitViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
