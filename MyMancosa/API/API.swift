//
//  API.swift
//  MyMancosa
//
//  Created by Nerudo Mregi on 2018/08/15.
//  Copyright © 2018 Nerudo Mregi. All rights reserved.
//

import Foundation
import Alamofire

class API {
    static let sharedInstance = API()
    let API_Root = "https://mymancosa-api.azurewebsites.net"
    
    //PUSH NOTIFICATION
    public func PushRegister(tags: String, deviceid: String, completion:@escaping ([String: Any]?, Error?)->Void) -> Void{
        
        let parameters: Parameters = [
            "Platform": "apns",
            "DeviceID" : deviceid,
            "Tags" : tags
        ]
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json"
        ]
        
        let urlEndpoint = API_Root+"/notifications/register"
        
        URLCache.shared.removeAllCachedResponses()
        Alamofire.request(urlEndpoint, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers)
            .responseString { response in
                print(response)
                guard response.result.isSuccess else {
                    print("Error while fetching data: \(String(describing: response.result.error))")
                    completion(nil, response.error)
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    completion(nil, response.error)
                    return
                }
                completion(responseJSON, nil)
        }
    }
    public func login(completion:@escaping ([String: Any])->Void) -> Void{
        
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "studentID")
        let password = defaults.string(forKey: "studentPassword")
        let parameters: Parameters = [
            "txt_username": username ?? "",
            "txt_password": password ?? ""
        ]
        let headers: HTTPHeaders = [
            "X-API-KEY": "2.0.0",
            "Accept": "application/json"
        ]
        
        let urlEndpoint = API_Root + "/auth"
        
        Alamofire.request(urlEndpoint, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
                completion(responseJSON)
        }
    }
    public func myprofile(completion:@escaping ([String: Any])->Void) -> Void{
        
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "studentID")
        let password = defaults.string(forKey: "studentPassword")
        let parameters: Parameters = [
            "txt_username": username ?? "",
            "txt_password": password ?? ""
        ]
        let headers: HTTPHeaders = [
            "X-API-KEY": "2.0.0",
            "Accept": "application/json"
        ]
        
        let urlEndpoint = API_Root + "/auth"
        
        Alamofire.request(urlEndpoint, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
                completion(responseJSON)
        }
    }
    public func assignmentsCalendar(completion:@escaping ([String: Any])->Void) -> Void{
        
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "studentID")
        let password = defaults.string(forKey: "studentPassword")
        let parameters: Parameters = [
            "txt_username": username ?? "",
            "txt_password": password ?? ""
        ]
        let headers: HTTPHeaders = [
            "X-API-KEY": "2.0.0",
            "Accept": "application/json"
        ]
        
        let urlEndpoint = API_Root + "/assignments/calendar"
        
        Alamofire.request(urlEndpoint, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
                completion(responseJSON)
        }
    }
    public func announcements(completion:@escaping ([String: Any])->Void) -> Void{
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "studentID")
        let password = defaults.string(forKey: "studentPassword")
        let parameters: Parameters = [
            "txt_username": username ?? "",
            "txt_password": password ?? ""
        ]
        let headers: HTTPHeaders = [
            "X-API-KEY": "2.0.0",
            "Accept": "application/json"
        ]
        
        let urlEndpoint = API_Root + "/announcements"
        
        Alamofire.request(urlEndpoint, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
                completion(responseJSON)
        }
    }
    public func books(completion:@escaping ([String: Any])->Void) -> Void{
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "studentID")
        let password = defaults.string(forKey: "studentPassword")
        let parameters: Parameters = [
            "txt_username": username ?? "",
            "txt_password": password ?? ""
        ]
        let headers: HTTPHeaders = [
            "X-API-KEY": "2.0.0",
            "Accept": "application/json"
        ]
        
        let urlEndpoint = API_Root + "/books"
        
        Alamofire.request(urlEndpoint, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
                completion(responseJSON)
        }
    }
    public func bookDetails(view: String, completion:@escaping ([String: Any])->Void) -> Void{
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "studentID")
        let password = defaults.string(forKey: "studentPassword")
        let parameters: Parameters = [
            "txt_username": username ?? "",
            "txt_password": password ?? "",
            "view" : view
        ]
        let headers: HTTPHeaders = [
            "X-API-KEY": "2.0.0",
            "Accept": "application/json"
        ]
        
        let urlEndpoint = API_Root + "/books/view"
        
        Alamofire.request(urlEndpoint, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
                completion(responseJSON)
        }
    }

    public func booksSearch(keyword: String, completion:@escaping ([String: Any])->Void) -> Void{
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "studentID")
        let password = defaults.string(forKey: "studentPassword")
        let parameters: Parameters = [
            "txt_username": username ?? "",
            "txt_password": password ?? "",
            "keywords" : keyword
        ]
        let headers: HTTPHeaders = [
            "X-API-KEY": "2.0.0",
            "Accept": "application/json"
        ]
        
        let urlEndpoint = API_Root + "/books/search"
        
        Alamofire.request(urlEndpoint, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
                completion(responseJSON)
        }
    }
    public func booksAdd(subjectName: String,
                         bookTitle: String,
                         author: String,
                         publications: String,
                         edition: String,
                         status: String,
                         expectedSellingPrice: String,
                         contactNumber: String,
                         completion:@escaping ([String: Any])->Void) -> Void{
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "studentID")
        let password = defaults.string(forKey: "studentPassword")
        let parameters: Parameters = [
            "txt_username": username,
            "txt_password": password,
            "bookTitle" : bookTitle,
            "author" : author,
            "publications" : publications,
            "edition" : edition,
            "status" : status,
            "expectedSellingPrice" : expectedSellingPrice,
            "contactNumber" : contactNumber
        ]
        let headers: HTTPHeaders = [
            "X-API-KEY": "2.0.0",
            "Accept": "application/json"
        ]
        
        let urlEndpoint = API_Root + "/books/add"
        
        Alamofire.request(urlEndpoint, method: .post, parameters : parameters, encoding: JSONEncoding.default, headers : headers)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching tags: \(String(describing: response.result.error))")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    return
                }
                completion(responseJSON)
        }
    }
}
