import Foundation
import WidgetKit

class WidgetCoordinator {
    static let shared = WidgetCoordinator()
    private let store: WidgetsStore
    private let observer: WidgetContentNotificationObserver

    private init() {
        self.store = WidgetsStore()
        self.observer = WidgetContentNotificationObserver(store: store)
    }
}

//"Open Items" : { "Punch": WidgetContent, "Correspondence": WidgetContent }

@available(iOS 14.0, *)
struct WidgetsStore {
    private var registeredWidgetKinds: [WidgetKind] = []
    private var contentByKind: [WidgetKind: [String: WidgetContent]] = [:]

    func reload(kind: WidgetKind, content: WidgetContent) {
        //contentByKind[kind] = content
        // TODO: write to telemetry?, whenever the content changes
        // TODO: write to shared container
        WidgetCenter.shared.reloadTimelines(ofKind: kind.rawValue)
    }
}

extension Notification.Name {
    public static let widgetContent = Notification.Name(rawValue: "Widget.content")
}

final class WidgetContentNotificationObserver {
    private let store: WidgetsStore

    init(store: WidgetsStore) {
        self.store = store
        configureObservations()
    }

    private func configureObservations() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(notification:)),
            name: NSNotification.Name.widgetContent,
            object: nil)
    }

    @objc func handleNotification(notification: Notification) {
        guard let data = notification.userInfo?[WidgetContentNotificationData.userInfoKey] as? WidgetContentNotificationData else {
            return
        }

        do {
            try WidgetContentReaderWriter().writeSnapshot(kind: data.kind,
                                                          tool: data.tool,
                                                          widgetContent: data.content)
            WidgetCenter.shared.reloadTimelines(ofKind: data.kind.rawValue)
        } catch {
            //Assertion???
            print("error")
        }
    }
}

