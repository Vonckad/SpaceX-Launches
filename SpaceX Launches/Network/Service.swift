//
//  Service.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import Foundation

protocol ServiceProtocol {
    func request(complition: @escaping (Data?, Error?) -> ())
    func requestLaunches(rocket: String, complition: @escaping (Data?, Error?) -> ())
    func loadImage(stringURL: String, complition: @escaping (Data?, Error?) -> ())
}

class Service: ServiceProtocol {
    
    func request(complition: @escaping (Data?, Error?) -> ()) {
        let url = url(isQuery: false)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        let dataTask = createDataTask(from: urlRequest, complition: complition)
        dataTask.resume()
//        print("url = \(url)")
    }
    
    func requestLaunches(rocket: String, complition: @escaping (Data?, Error?) -> ()) {
        let param = [
            "query": [
                "rocket": [
                    "\(rocket)"
                ]
            ],
            "options": [
                "sort" : [
                    "date_utc": "desc"
                ]
            ]
        ]
        
        let url = url(isQuery: true)
        var urlRequest = URLRequest(url: url)
        let headers = [ "Content-Type": "application/json" ]
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: param)
        urlRequest.allHTTPHeaderFields = headers
        let dataTask = createDataTask(from: urlRequest, complition: complition)
        dataTask.resume()
//        print("url = \(url)")
    }
    
    func loadImage(stringURL: String, complition: @escaping (Data?, Error?) -> ()) {
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: stringURL) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    complition(data, error)
                }
            }.resume()
        }
    }
    
    private func createDataTask(from request: URLRequest, complition: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
    }

    private func url(isQuery: Bool) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spacexdata.com"
        components.path = isQuery ? "/v4/launches/query" : "/v4/rockets"
        return components.url!
    }
}
