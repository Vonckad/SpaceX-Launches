//
//  MainRouter.swift
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

@objc protocol MainRoutingLogic
{
    func routeToSomewhere(index: Int)
//  func addDataLaunches()
}

protocol MainDataPassing
{
  var dataStore: MainDataStore? { get }
}

class MainRouter: NSObject, MainRoutingLogic, MainDataPassing
{
  weak var viewController: MainViewController?
  var dataStore: MainDataStore?
  
  // MARK: Routing
  
//    private var destinationVC = LaunchesTableViewController()
    
  func routeToSomewhere(index: Int)
  {
      let destinationVC = LaunchesTableViewController(rocketName: dataStore?.model[index].name ?? "", rocketID: dataStore?.model[index].id ?? "")
      navigateToSomewhere(source: viewController!, destination: destinationVC)
  }

  // MARK: Navigation
  
  func navigateToSomewhere(source: MainViewController, destination: LaunchesTableViewController)
  {
    source.navigationController?.pushViewController(destination, animated: true)
  }

//   MARK: Passing data

//  func passDataToSomewhere(source: MainDataStore, destination: inout LaunchesTableViewControllerDataStore)
//  {
//      destination.launchesModel = source.modelRocketLaunches
//  }
}
