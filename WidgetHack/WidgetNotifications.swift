import Foundation

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
        store.reload(kind: data.kind, tool: data.tool, content: data.content)
    }
}

