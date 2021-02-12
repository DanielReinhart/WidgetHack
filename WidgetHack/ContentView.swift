//
//  ContentView.swift
//  WidgetHack
//
//  Created by Daniel Reinhart on 2/10/21.
//

import SwiftUI

struct ContentView: View {
    let coordinator = WidgetCoordinator.shared
    var tools: [WidgetTool] = [.punch, .coordinationIssues, .rfi]
    let projectName = "My Test Project"
    @State var numberOfPunchItems: String = "0"
    @State var numberOfRFIItems: String = "0"
    @State var numberOfCoordinationIssues: String = "0"

    private struct ToolListImage: View {
        let imageName: String

        var body: some View {
            Image("ToolList/\(imageName)")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.black)
                .frame(width: 22, height: 22)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text(self.projectName)
                .font(.largeTitle)
            List {
                ForEach(tools, id: \.self) { tool in
                    HStack {
                        ToolListImage(imageName: tool.imageName)
                        Text(verbatim: tool.displayName)
                        Spacer()
                        switch tool {
                        case .punch:
                            TextField("Amount", text: $numberOfPunchItems)
                                .keyboardType(.decimalPad)
                                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        case .coordinationIssues:
                            TextField("Amount", text: $numberOfCoordinationIssues)
                                .keyboardType(.decimalPad)
                                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        case .rfi:
                            TextField("Amount", text: $numberOfRFIItems)
                                .keyboardType(.decimalPad)
                                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        }
                        Button("Save") {
                            postNotification(tool: tool)
                        }
                    }
                }
            }
        }.padding()
    }

    // TODO: do this via a WidgetContentFormatter
    func makeContent(tool: WidgetTool) -> WidgetContent {
        WidgetContent(
            title: projectName,
            subtitle: tool.displayName,
            imageName: tool.imageName,
            primaryContent: "\(numberOfItems(tool: tool)) items",
            secondaryContent: "14 items in the project",
            count: numberOfItems(tool: tool),
            updatedAt: "last updated: now")
    }

    func postNotification(tool: WidgetTool) {
        let content = makeContent(tool: tool)
        WidgetContentNotificationPoster.post(with: content,
                                             tool: tool,
                                             kind: .openItems)
    }

    func numberOfItems(tool: WidgetTool) -> String {
        switch tool {
        case .punch:
            return numberOfPunchItems
        case .coordinationIssues:
            return numberOfCoordinationIssues
        case .rfi:
            return numberOfRFIItems
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
