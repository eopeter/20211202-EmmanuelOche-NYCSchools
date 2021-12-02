//
//  School.swift
//  schools
//
//  Created by Emmanuel Oche on 12/1/21.
//

import Foundation
//import CoreData
//
//@objc(School)
//class School: NSManagedObject, Identifiable {
//    @NSManaged var dbn: String
//    @NSManaged var school_name: String
//
//    var school : HighSchool {
//        get {
//            return HighSchool(dbn: self.dbn, school_name: self.school_name)
//        }
//        set {
//            self.dbn = newValue.dbn
//            self.school_name = newValue.school_name
//        }
//    }
//}

struct School: Codable, Identifiable {
    var id: String { dbn }
    var dbn: String
    var school_name: String
}

struct SatData: Codable, Identifiable {
    var id: String { dbn }
    var dbn: String
    var school_name: String
    var num_of_sat_test_takers: String
    var sat_critical_reading_avg_score: String
    var sat_math_avg_score: String
    var sat_writing_avg_score: String
}
