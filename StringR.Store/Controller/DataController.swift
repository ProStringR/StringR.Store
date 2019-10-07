//
//  DataController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class DataController {

    func getData<T: Codable>(returnType: T.Type, url: String, completion: @escaping (T?) -> Void) throws {

        guard let url = URL(string: "\(url).json") else { throw Exception.url }

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

    func putData<T: Codable>(objectToUpdate object: T, objectId: String, url: String) throws {
        guard let url = URL(string: "\(url)/\(objectId).json") else { throw Exception.url }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"

        do {
            let data = try JSONEncoder().encode(object)
            request.httpBody = data
        } catch {
            throw Exception.error
        }

        URLSession.shared.dataTask(with: request as URLRequest).resume()
    }

    func deleteData(objectIdToDelete objectId: String, url: String) throws {
        guard let url = URL(string: "\(url)/\(objectId).json") else { throw Exception.url }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request as URLRequest).resume()
    }

    func createObject<T: Codable, P: Codable>(fromObject: T, toObject: P.Type) -> P? {
        do {
            let json = try JSONEncoder().encode(fromObject)
            let newObject = try JSONDecoder().decode(toObject, from: json)

            return newObject
        } catch {
            return nil
        }
    }
}
