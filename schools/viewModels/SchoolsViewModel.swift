//
//  SchoolsViewModel.swift
//  schools
//
//  Created by Emmanuel Oche on 12/1/21.
//

import Foundation
//if i had time, I will use coredata to allow offline viewing of the data when api is unreachable
//import CoreData

final class SchoolsViewModel: ObservableObject {
    
    private let schoolsApi: ISchoolsApi
    
    @Published var schools = [School]()
    @Published var satLookUp = [String: SatData]()
    @Published var loading = true
    var schoolsLoaded = false
    var satLoaded = false
    @Published var hasError = false
    
    init(schoolsApiService: ISchoolsApi) {
        self.schoolsApi = schoolsApiService
    }
    
    //reload used by the view to reload data from the api
    public func reload() {
        loading = true
        loadSchoolData {
            self.setLoadStatus()
        }
        loadSatData{
            self.setLoadStatus()
        }
    }

    //loadData initially loads the data from the api if not loaded
    public func loadData() {
        if schools.count == 0 {
            loadSchoolData{
                self.setLoadStatus()
            }
        }
        if satLookUp.count == 0 {
            loadSatData {
                self.setLoadStatus()
            }
        }
    }
    
    //setLoadStatus set loading staus based on loading status for schools and sat scores
    func setLoadStatus() {
        self.loading = self.schoolsLoaded && self.satLoaded
    }
    
    public func loadSchoolData(completion: @escaping () -> Void){
        self.hasError = false
        self.schoolsApi.loadSchoolData { result in
            switch result {
            case .success(let schools):
                self.schools = schools
            case .failure(let error):
                self.hasError = true
                print(error.localizedDescription)
            }
            self.loading = false
            completion()
        }
    }
    
    public func loadSatData(completion: @escaping () -> Void){
        self.schoolsApi.loadSatData{ result in
            switch result {
            case .success(let satData):
                self.satLookUp = satData.reduce(into: [String: SatData]()){
                    $0[$1.dbn] = $1
                }
            case .failure(let error):
                //need to let user know there was an error
                print(error.localizedDescription)
            }
            completion()
        }
    }
    
}

