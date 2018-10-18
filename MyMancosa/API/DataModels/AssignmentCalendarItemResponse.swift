// To parse the JSON, add this file to your project and do:
//
//   let assignmentCalendarItem = try? newJSONDecoder().decode(AssignmentCalendarItem.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAssignmentCalendarItem { response in
//     if let assignmentCalendarItem = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

class AssignmentCalendarItem{
    let programmeName, intake, year, assignmentNo: String
    let moduleName, dueDate, remark: String
    
    init(programmeName: String, intake: String, year: String, assignmentNo: String, moduleName: String, dueDate: String, remark: String) {
        self.programmeName = programmeName
        self.intake = intake
        self.year = year
        self.assignmentNo = assignmentNo
        self.moduleName = moduleName
        self.dueDate = dueDate
        self.remark = remark
    }
}
