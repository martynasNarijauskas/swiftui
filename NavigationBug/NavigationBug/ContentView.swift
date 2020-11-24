//
//  ContentView.swift
//  NavigationBug
//
//  Created by Martynas Narijauskas on 2020-11-24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published
    var shouldHideUserInfo = false
}


struct ContentView: View {
    
    @EnvironmentObject
    var appState: AppState
    
    @State
    var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if !appState.shouldHideUserInfo {
                    Text("USER INFO")
                }
                
                NavigationLink(
                    destination: ViewA(),
                    tag: 1,
                    selection: $selection,
                    label: { EmptyView()})
                
                Button("MOVE TO VIEW A") {
                    selection = 1
                }
            }
        }
    }
}


class ViewAModel: ObservableObject {
    @Published
    var selection: Int? = nil
    
    func navigate() {
        selection = 2 //<- this doesnt
    }
}

struct ViewA: View {
    
    @ObservedObject
    var viewModel: ViewAModel
    
    init() {
        viewModel = ViewAModel()
    }

    @State
    var selection: Int? = nil //<- this works
    
    var body: some View {
        VStack
        {
            Text("VIEW A")
            
            NavigationLink(
                destination: ViewB(),
                tag: 2,
                selection: $viewModel.selection,
                label: { EmptyView()})
            
            Button("MOVE TO VIEW B") {
                //selection = 2 <-- this works
                viewModel.navigate() //<- this doesnt
            }
           
        }
    }
}



struct ViewB: View {
    
    @EnvironmentObject
    var appState: AppState

    @State
    var selection: Int? = nil
    
    var body: some View {
        VStack
        {
            Text("VIEW B")
           
        }
        .onAppear {
            appState.shouldHideUserInfo = true
        }
    }
}
