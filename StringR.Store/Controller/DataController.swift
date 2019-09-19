//
//  DataController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class DataController {

    static func fetchData<T: Codable>(returnType: T.Type, url: String) throws -> T {
        guard let url = URL(string: "\(url).json") else { throw NetworkError.url }

        var dataFromUrl: Data?
        var responseFromUrl: URLResponse?
        var errorFromUrl: Error?

        let semaphore = DispatchSemaphore(value: 0)

        URLSession.shared.dataTask(with: url) {(data, response, error) in
            dataFromUrl = data
            responseFromUrl = response
            errorFromUrl = error

            semaphore.signal()
            }.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        if let statusCode = responseFromUrl as? HTTPURLResponse, statusCode.statusCode > 300 {
            throw NetworkError.statusCode
        }

        if errorFromUrl != nil {
            throw NetworkError.error
        }

        guard let dataResponse = dataFromUrl else {
            throw NetworkError.error
        }

        do {
            let data = try JSONDecoder().decode(returnType, from: dataResponse)
            return data
        } catch {
            throw NetworkError.error
        }
    }
}
