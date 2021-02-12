import Foundation

class WidgetCoordinator {
    static let shared = WidgetCoordinator()
    private let store: WidgetsStore
    private let observer: WidgetContentNotificationObserver

    private init() {
        self.store = WidgetsStore()
        self.observer = WidgetContentNotificationObserver(store: store)
    }
}
