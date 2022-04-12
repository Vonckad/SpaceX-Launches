//
//  MainInteractor.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MainBusinessLogic
{
    func doSomething(request: Main.Something.Request.RequestType)
}

protocol MainDataStore
{
    var model: [SpaceRocketModel] { get set }
    var modelRocketLaunches: LaunchesModel { get set }
}

class MainInteractor: MainBusinessLogic, MainDataStore
{
  var presenter: MainPresentationLogic?
  var worker: MainWorker?
  var model = [SpaceRocketModel]()
  var modelRocketLaunches: LaunchesModel = .init(docs: [])
  
    // MARK: Do something
  
    func doSomething(request: Main.Something.Request.RequestType)
  {
    worker = MainWorker()
    worker?.doSomeWork()
      
      switch request {
      case .getSpaceRocket:
          let service: ServiceFetcherProtocol = ServiceFetcher()
          service.fetchSpaceRokets { result in
              self.model = result ?? [SpaceRocketModel]()
              self.presenter?.presentSomething(response: .presentSpaceRocket(result ?? [SpaceRocketModel]()))
          }
//      case .getRocketLaunches(let rocket):
//          presenter?.presentSomething(response: .presentRocketLaunches)
//          let service: ServiceFetcherProtocol = ServiceFetcher()
//          service.fetchSpaceRokets(rocket: rocket) { launches in
//              guard let launches = launches else { return }
//              self.modelRocketLaunches = launches
//              self.presenter?.presentSomething(response: .loadedDataRocketLaunches)
//              self.presenter?.presentSomething(response: .presentRocketLaunches)
//          }
      }
  }
}