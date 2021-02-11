//
//  ContentView.swift
//  WidgetHack
//
//  Created by Daniel Reinhart on 2/10/21.
//

import SwiftUI

struct ContentView: View {
    let coordinator = WidgetCoordinator.shared
    
    var body: some View {
        Button("Save Data For Punch") {
            postNotification()
        }
    }

    func postNotification() {
        let content = WidgetContent(title: "My Project",
                                    subtitle: "Punch",
                                    imageName: "Punch",
                                    value: "5 Open Items")
        
        WidgetContentNotificationPoster.post(with: content,
                                             tool: "punch",
                                             kind: .openItems)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
