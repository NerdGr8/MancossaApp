// To parse the JSON, add this file to your project and do:
//
//   let books = try? newJSONDecoder().decode(Books.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseBooks { response in
//     if let books = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class BookItemResponse: Codable {
    let success: String
    let data: [BookItem]
    let message: String
    
    init(success: String, data: [BookItem], message: String) {
        self.success = success
        self.data = data
        self.message = message
    }
}
enum BookItemKeys: String {
    case sNo = "S_No"
    case subjectName = "SubjectName"
    case bookTitle = "BookTitle"
    case authorName = "AuthorName"
    case publications = "Publications"
    case view = "View"
}
class BookItem: Codable {
    let sNo, subjectName, bookTitle, authorName: String
    let publications, view: String
    
   
    
    init(sNo: String, subjectName: String, bookTitle: String, authorName: String, publications: String, view: String) {
        self.sNo = sNo
        self.subjectName = subjectName
        self.bookTitle = bookTitle
        self.authorName = authorName
        self.publications = publications
        self.view = view
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
    func responseBooks(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<BookItemResponse>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
