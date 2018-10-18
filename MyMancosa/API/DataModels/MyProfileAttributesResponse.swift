// To parse the JSON, add this file to your project and do:
//
//   let myProfileAttributes = try? newJSONDecoder().decode(MyProfileAttributes.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMyProfileAttributes { response in
//     if let myProfileAttributes = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class MyProfileAttributesResponse: Codable {
    let success: String
    let data: [[String]]
    let message: String
    
    init(success: String, data: [[String]], message: String) {
        self.success = success
        self.data = data
        self.message = message
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseMyProfileAttributes(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<MyProfileAttributesResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
