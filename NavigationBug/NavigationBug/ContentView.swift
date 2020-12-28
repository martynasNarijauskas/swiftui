import SwiftUI

struct MainView: View {
    var body: some View {
        TestView()
    }
}

struct TestView: View {

    let hideUserInfo = NotificationCenter.default
                .publisher(for: NSNotification.Name("HideUserInfo"))

    let showUserInfo = NotificationCenter.default
                .publisher(for: NSNotification.Name("ShowUserInfo"))

    @State
    var shouldShowHeader = true

    @State
    var selection: Int? = 0

    var body: some View {

        ZStack {
            VStack {
                if shouldShowHeader {
                    Text("Test")
                }
                NavigationView {
                    ZStack {
                        Color.green.ignoresSafeArea()
                    VStack {
                        NavigationLink(
                            destination: TestView2(),
                            tag: 1,
                            selection: $selection,
                            label: {
                                EmptyView()
                            })
                        Button(
                            action: {
                                selection = 1
                            },
                            label: {
                                Text("Button")
                            }
                        )
                    }
                }
                //.navigationViewStyle(StackNavigationViewStyle())
                .navigationBarHidden(true)
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }.onReceive(hideUserInfo) { info in
        self.shouldShowHeader = false
    }
    .onReceive(showUserInfo) { info in
        self.shouldShowHeader = true
    }


    }
}


struct TestView2: View {
    @State
    var selection: Int? = 0

    var body: some View {

        ZStack {
            Color.green.ignoresSafeArea()
        ScrollView {
            NavigationLink(
                destination: OpenedView(),
                tag: 1,
                selection: $selection,
                label: {
                    EmptyView()
                })
            Button(
                action: {
                    selection = 1
                },
                label: {
                    Text("Button")
                }
            )
            LazyVStack {
                Image(systemName: "star").resizable().frame(width: 100, height: 100)
                Image(systemName: "star").resizable().frame(width: 100, height: 100)
                Image(systemName: "star").resizable().frame(width: 100, height: 100)
                Image(systemName: "star").resizable().frame(width: 100, height: 100)
                Image(systemName: "star").resizable().frame(width: 100, height: 100)
                Image(systemName: "star").resizable().frame(width: 100, height: 100)
                Image(systemName: "star").resizable().frame(width: 100, height: 100)
                Image(systemName: "star").resizable().frame(width: 100, height: 100)

            }

        }
        }
        .onAppear {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "ShowUserInfo")))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct OpenedView: View {

    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @State
    var selection: Int? = 0

    var body: some View {
            VStack {
                Button(
                    action: {
                        mode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("Go bck")
                    }
                )
            }.onAppear {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "HideUserInfo")))
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
    }
}
