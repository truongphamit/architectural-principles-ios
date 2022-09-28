//
//  AppDIContainer.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 14/09/2022.
//

import Foundation
import UIKit

final class AppDIContainer {
    lazy var jsonDecoder = JSONDecoder()
    
    lazy var interceptors = [LoggingInterceptor()]
    
    lazy var apiClient = APIClient(baseUrl: "https://dev-api.tripi.vn/flights/", decoder: jsonDecoder, interceptors: interceptors)
    
    lazy var flightApi: FlightApi = FlightApiImpl(apiClient: apiClient)
    
    func createMainViewController(actions: MainViewControllerActions) -> MainViewController {
        return MainViewController.create(actions: actions)
    }
    
    func createUIKitViewController() -> UIViewController {
        return UiKitViewController.create(with: createUIKitViewModel())
    }
    
    func createUIKitViewModel() -> UIKitViewModel {
        return UIKitViewModel(flightApi: flightApi)
    }
}
