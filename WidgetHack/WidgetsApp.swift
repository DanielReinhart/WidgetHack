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

    }
}

