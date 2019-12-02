//
//  DataController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class DataController {

    func getData<T: Codable>(returnType: T.Type, url: String, completion: @escaping (T?) -> Void) {

        guard let url = URL(string: "\(url).json") else { completion(nil); return }

        URLSession.shared.dataTask(with: url) {(data, response, error) in
            // TODO: if we want to handle the error or respons
            _ = response
            _ = error

            if let data = data {
                do {
                    let object = try JSONDecoder().decode(returnType, from: data)
                    completion(object)
                } catch {
                    completion(nil)
                }
            }
        }.resume()
    }

    func getListOfData<T: Codable>(returnType: T.Type, url: String, completion: @escaping ([T]?) -> Void) {
        getData(returnType: [String: T?].self, url: url) { (result) in
            guard let result = result else { completion(nil); return }

            var listToReturn: [T]? = []

            for item in result {
                if let object = item.value {
                    listToReturn?.append(object)
                }
            }

            completion(listToReturn)
        }
    }

    func postData<T: Codable>(object: T, url: String) throws {
        guard let url = URL(string: "\(url).json") else { throw Exception.url }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let data = try JSONEncoder().encode(object)
            request.httpBody = data
        } catch {
            throw Exception.error
        }

        URLSession.shared.dataTask(with: request as URLRequest).resume()
    }

    func putData<T: Codable>(objectToUpdate object: T, objectId: String, url: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(url)/\(objectId).json") else { completion(false); return }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"

        do {
            let data = try JSONEncoder().encode(object)
            request.httpBody = data
        } catch {
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            _ = data

            if error != nil {
                completion(false)
            }

            if let response = response as? HTTPURLResponse {
                if response.statusCode < 300, response.statusCode >= 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }.resume()
    }

    func deleteData(objectIdToDelete objectId: String, url: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(url)/\(objectId).json") else { completion(false); return }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            _ = data

            if error != nil {
                completion(false)
            }

            if let response = response as? HTTPURLResponse {
                if response.statusCode < 300, response.statusCode >= 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }.resume()
    }

    func createObject<T: Codable, P: Codable>(fromObject: T?, toObject: P.Type) -> P? {
        guard let object = fromObject else { return nil }

        do {
            let json = try JSONEncoder().encode(object)
            let newObject = try JSONDecoder().decode(toObject, from: json)
            return newObject
        } catch {
            return nil
        }
    }

    func authenticateShop<T: Codable>(body object: T, url: String, completion: @escaping (LoginResponse?) -> Void) {
        guard let url = URL(string: url) else { completion(nil); return }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let data = try JSONEncoder().encode(object)
            request.httpBody = data
        } catch {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            _ = data

            var isGoodResponse = false

            if error != nil {
                completion(nil)
            }

            if let response = response as? HTTPURLResponse {
                if response.statusCode < 300, response.statusCode >= 200 {
                    isGoodResponse = true
                } else {
                    completion(nil)
                }
            }

            if let data = data {
                if isGoodResponse {
                    do {
                        let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                        completion(response)
                    } catch {
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
