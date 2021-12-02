//
//  ContentView.swift
//  schools
//
//  Created by Emmanuel Oche on 12/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var viewModel: SchoolsViewModel
    
    var body: some View {
        ZStack {
            NavigationView{
                VStack{
                    if !viewModel.hasError {
                        List{
                            Section(header: ListHeader()) {
                                ForEach(viewModel.schools) { school in
                                    NavigationLink(
                                        destination: SchoolSatScoreView(satData: viewModel.satLookUp[school.dbn], schoolName: school.school_name),
                                        label: {
                                            Text(school.school_name)
                                        })
                                }
                            }
                        }.listStyle(GroupedListStyle())
                        .onAppear(){
                            viewModel.loadData()
                        }
                    }else{
                        Text("An error occured \nwhile loading the data")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 22))
                    }
                }
                .navigationTitle(MAIN_TITLE)
                .navigationBarTitleDisplayMode(.inline)
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
            ActivityIndicator(isAnimating: viewModel.loading)
        }
        
    }
    
    struct ListHeader: View {
        @State var searchTerm = ""
        var body: some View {
            SearchBar(searchTerm: $searchTerm)
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

