
//  TrackerGGNetworkManager.swift
//  ApexTracker
//
//  Created by Захар  Сегал on 21.04.2020.
//  Copyright © 2020 Захар  Сегал. All rights reserved.


import Foundation

/// in  .allProfileStats first parameter is the platform on wich player is playing, second parameter: userId
///   .profileSegment first parameter is the platform on wich player is playing, second parameter: userId, third param: current segmen of datat in profile info array
///   .matchHistory first parameter is the platform on wich player is playing, second parameter: userId
enum SpecialPath {
    case allProfileStats(String, String)
    case profileSegment(String, String, String)
    case matchHistory(String, String)
}


struct TrackerGGNetworkManager {
    static let environment : TrackerGGNetworkEnvironment = .main
    static let TrackerGGApiKey = "c18c9a63-b358-412f-967b-e16457ecd073"
    let router = NetworkRouter<TrackerGGApi>()
    
    func getProfileStats(platform: TrackerGGPlatform, userId: String, completion: @escaping (_ movie: TrackerProfileResponse?,_ error: String?)->()){
        router.request(.allProfileStats, specialPath: .allProfileStats(platform.rawValue, userId)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(TrackerProfileResponse.self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error.localizedDescription)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
//    func getProfileSegmentplatform(platform: TrackerGGPlatform, userId: String, segment: String, completion: @escaping (_ movie: MozambiqueNewsAPIResponse?,_ error: String?)->()) {
//
//    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...500: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
