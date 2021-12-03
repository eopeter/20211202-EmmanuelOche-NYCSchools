//
//  ContentView.swift
//  schools
//
//  Created by Emmanuel Oche on 12/1/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: SchoolsViewModel
    
    var body: some View {
        ZStack {
            NavigationView{
                VStack{
                    if !viewModel.hasError {
                        SchoolListView(viewModel: viewModel)
                    }
                    else{
                        Text("An error occured \nwhile loading the data")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 22))
                    }
                }
                .navigationTitle(MAIN_TITLE)
                .toolbar {
                    Button(action: viewModel.reload) {
                        Label("Reload", systemImage: "arrow.clockwise")
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
                        Text("Found \(viewModel.schools.count) High Schools")
                            .font(.system(size: 15))
                        Spacer()
                    }
                }
            }
            //loading indicator
            ActivityIndicator(isAnimating: !viewModel.doneLoading)
        }
        
    }
    
    //construct the ListView to show the schools
    struct SchoolListView: View {
        
        @StateObject var viewModel: SchoolsViewModel
        @State var searchTerm = ""
        
        var body: some View {
            List{
                ForEach(viewModel.schools.filter({ searchTerm.isEmpty ? true : $0.school_name.contains(searchTerm)})) { school in
                    NavigationLink(
                        destination: SchoolSatScoreView(satData: viewModel.satLookUp[school.dbn], schoolName: school.school_name),
                        label: {
                            Text(school.school_name)
                            //since the full school name is available on the next page, may be ok to
                            //limit the lines to 1 and truncate excess char for aesthetics
                            //but leave to PO to decide
                                .lineLimit(1)
                                .truncationMode(Text.TruncationMode.tail)
                        })
                }
            }
            .searchable(text: $searchTerm)
            .listStyle(InsetListStyle())
            .onAppear(){
                viewModel.loadData()
            }
        }
    }
    
}

struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    fileprivate var configuration = { (indicator: UIView) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}

