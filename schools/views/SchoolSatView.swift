//
//  SchoolDetails.swift
//  schools
//
//  Created by Emmanuel Oche on 12/1/21.
//

import Foundation
import SwiftUI

struct SchoolSatScoreView : View {
    let satData: SatData?
    let schoolName: String
    
    var body: some View {
        VStack(spacing: 20){
            Text(schoolName).font(.title)
                .multilineTextAlignment(.center)
                .padding([.top, .leading, .trailing])
            if let data = satData {
                
                List {
                    HStack{
                        Spacer()
                        VStack {
                            Text(data.num_of_sat_test_takers).font(.system(size: 70))
                                .multilineTextAlignment(.center)
                            Text("Number of Test Takers")
                                .padding(.bottom)
                        }.padding()
                        Spacer()
                    }
                    Text("Average Score")
                    HStack{
                        Text("SAT Critical Reading Avg. Score")
                        Spacer()
                        Text(data.sat_critical_reading_avg_score)
                    }
                    HStack{
                        Text("SAT Math Avg. Score")
                        Spacer()
                        Text(data.sat_math_avg_score)
                    }
                    HStack{
                        Text("SAT Writing Avg. Score")
                        Spacer()
                        Text(data.sat_writing_avg_score)
                    }
                    VStack{
                        //using a static chart. if data is available, will be nice to show the score distribution
                        Text("Proposed SAT Distribution Chart")
                            .multilineTextAlignment(.center)
                        Image("chart")
                            .resizable()
                    }.padding(.top)
                }.listStyle(InsetListStyle())
                
            }else{
                Spacer()
                Text("No Data")
                    .foregroundColor(.gray)
                    .font(.system(size: 60, weight: Font.Weight.bold, design: Font.Design.default))
                    .multilineTextAlignment(.center)
                Spacer()
            }
            
        }
        .navigationTitle("SAT Details")
    }
}
