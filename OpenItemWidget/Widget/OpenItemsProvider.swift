import WidgetKit

struct OpenItemsProvider: TimelineProvider {
    typealias Entry = WidgetEntry

    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry.mock
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> ()) {
        completion(WidgetEntry.mock)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [WidgetEntry] = []
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
