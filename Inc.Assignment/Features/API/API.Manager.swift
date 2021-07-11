//
//  API.Manager.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit
import RealmSwift

extension API {

    class Manager: NSObject {

        private let session: URLSession
        private var dataTask: URLSessionDataTask?

        override init(){
            self.session = URLSession.shared
            super.init()

        }

        public func fetchData<T:Codable>(codable: [T].Type,url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
            let dataTask = session.dataTask(with: url) { (data, response, error) in

                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }

                if response == nil || data == nil {
                    DispatchQueue.main.async {
                        completion(.failure(error!))
                    }
                    return
                }

                guard let data = data else {
                    assertionFailure()
                    return
                }

                do {

                    let result = try JSONDecoder().decode([T].self, from: data)

                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch let error {
                    completion(.failure(error))
                    return
                }
            }
            dataTask.resume()
        }

        public func cancelTask() {
            dataTask?.cancel()
        }
    }
}
