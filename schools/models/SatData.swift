//
//  SatData.swift
//  schools
//
//  Created by Emmanuel Oche on 12/2/21.
//

import Foundation

struct SatData: Codable, Identifiable {
    var id: String { dbn }
    var dbn: String
    var school_name: String
    var num_of_sat_test_takers: String
    var sat_critical_reading_avg_score: String
    var sat_math_avg_score: String
    var sat_writing_avg_score: String
}
