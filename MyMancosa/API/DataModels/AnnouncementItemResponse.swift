// To parse the JSON, add this file to your project and do:
//
//   let announcementItem = try? newJSONDecoder().decode(AnnouncementItem.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAnnouncementItem { response in
//     if let announcementItem = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class AnnouncementItemResponse: Codable {
    let success: String
    let data: [String]
    let message: String
    
    init(success: String, data: [String], message: String) {
        self.success = success
        self.data = data
        self.message = message
    }
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
    func responseAnnouncementItem(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<AnnouncementItemResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
