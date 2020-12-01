
import SwiftUI

class TabsViewModel: ObservableObject {
    var shopView: some View {
        ViewsBuilder.makeShopView()
    }
    
    struct ViewsBuilder {
        static func makeShopView() -> some View {
            ShopView(viewModel: .init())
        }
    }
}

//To reproduce go to second tab, view is loaded, go to first tab and then again go to second one
struct TabsView: View {
    
    @ObservedObject
    var viewModel: TabsViewModel
    
    @State
    private var selection = 1
    
    var body: some View {
        TabView(
            selection: $selection) {
                Text("Tab Content 1")
                    .tabItem {
                        if selection == 1 {
                            Image(systemName: "star.fill")
                        } else {
                            Image(systemName: "star")
                        }
                        //it works if I set Image(systemName: "star.fill") instead of if statement
                    }
                    .tag(1)
                viewModel
                    .shopView
                    .tabItem {
                        if selection == 2 {
                            Image(systemName: "star.fill")
                        } else {
                            Image(systemName: "star")
                        }
                        //it works if I set Image(systemName: "star.fill") instead of if statement
                    }
                    .tag(2)
            }
    }
}


struct ShopView: View {
    
    @ObservedObject
    var viewModel: ShopViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.mockedUser) { user in
                Text(user.name)
            }
        }
        .onAppear() {
            viewModel.mockApiCall()
        }
        
    }
}

class ShopViewModel: ObservableObject {
    
    @Published
    var mockedUser: [TestUser] = []
    
    func mockApiCall() {
        print("API CALLED")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.mockedUser = [
                TestUser(id: 1, name: "Test"),
                TestUser(id: 2, name: "User2")
            ]
        }
    }
    
    struct TestUser: Identifiable {
        let id: Int
        let name: String
    }
}
