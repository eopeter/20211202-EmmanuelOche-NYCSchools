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
    
    //properties observed by the view
    @Published var schools = [School]()
    @Published var satLookUp = [String: SatData]()
    @Published var doneLoading = false
    @Published var hasError = false
    
    //api load status
    var schoolsLoading = false
    var satLoading = false
    
    //inject the API interface
    init(schoolsApiService: ISchoolsApi) {
        self.schoolsApi = schoolsApiService
    }
    
    //reload used by the view to reload data from the api
    public func reload() {
        doneLoading = true
        loadSchoolData {
            self.setLoadStatus()
        }
        loadSatData{
            self.setLoadStatus()
        }
    }

    //loadData initially loads the data from the api if not loaded
    public func loadData() {
        doneLoading = true
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
        self.doneLoading = !self.schoolsLoading && !self.satLoading
    }
    
    //load school data from API. public to allow unit testing but it does not need to be exposed to the UI
    public func loadSchoolData(completion: @escaping () -> Void){
        self.hasError = false
        self.schoolsLoading = true
        self.schoolsApi.loadSchoolData { result in
            switch result {
            case .success(let schools):
                //could save the result in CoreData
                self.schools = schools
            case .failure(let error):
                self.hasError = true
                print(error.localizedDescription)
            }
            self.schoolsLoading = false
            completion()
        }
    }
    
    //load SAT data from API. public to allow unit testing but it does not need to be exposed to the UI
    public func loadSatData(completion: @escaping () -> Void){
        self.satLoading = true
        self.schoolsApi.loadSatData{ result in
            switch result {
            case .success(let satData):
                //could save the result in CoreData
                //using a dictionary to allow quick lookup of SAT data by school dbn/id
                self.satLookUp = satData.reduce(into: [String: SatData]()){
                    $0[$1.dbn!] = $1
                }
            case .failure(let error):
                //need to let user know there was an error
                print(error.localizedDescription)
            }
            self.satLoading = false
            completion()
        }
    }
    
}

