//
//  Router.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 20.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouterProtocol: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, specialPath: SpecialPath?, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class NetworkRouter<EndPoint: EndPointType>: NetworkRouterProtocol {
    
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, specialPath: SpecialPath?, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route, withSpecialPath: specialPath)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                DispatchQueue.main.async {
                    completion(data, response, error)
                }
            })
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint, withSpecialPath specialPath: SpecialPath?) throws -> URLRequest {
        
        var finalURL: URL
        
        if let specialPath = specialPath {
            let urlFactory = SpecialURLFactory(baseURL: route.baseURL)
            finalURL = urlFactory.buildURLWithSpecialPath(path: specialPath)
        } else {
            finalURL = route.baseURL.appendingPathComponent(route.path)
        }
        var request = URLRequest(url: finalURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestHeaders(let additionalHeaders):
                 self.addAdditionalHeaders(additionalHeaders, request: &request)
                
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}

