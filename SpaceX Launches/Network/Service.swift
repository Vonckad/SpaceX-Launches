//
//  Service.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import Foundation

protocol ServiceProtocol {
    func request(complition: @escaping (Data?, Error?) -> ())
}

class Service: ServiceProtocol {
    
    func request(complition: @escaping (Data?, Error?) -> ()) {
        let url = url()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let dataTask = createDataTask(from: urlRequest, complition: complition)
        dataTask.resume()
        print("url = \(url)")
    }
    
    private func createDataTask(from request: URLRequest, complition: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
    }

    private func url() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spacexdata.com"
        components.path = "/v4/rockets" //: "/v4/launches"
        return components.url!
    }
}
