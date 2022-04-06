//
//  ServiceFetcher.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import Foundation

protocol ServiceFetcherProtocol {
    func fetchSpaceRokets(complition: @escaping ([SpaceRocketModel]?) -> Void)
}

class ServiceFetcher: ServiceFetcherProtocol {

    var service: ServiceProtocol = Service()
    
    deinit {
        print("deinit")
    }
    
    func fetchSpaceRokets(complition: @escaping ([SpaceRocketModel]?) -> Void) {
        service.request() { data, error in
            if let error = error {
                print("error request = \(error.localizedDescription )")
                complition(nil) //можно подумать передать ошибку дальше
            }
            let decod = self.decodJSON(type: [SpaceRocketModel].self, from: data)
            complition(decod)
        }
    }

    private func decodJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let object = try decoder.decode(type.self, from: data)
            return object
        } catch let jsonError {
            print("jsonError = \(jsonError)")
            return nil
        }
    }
}
