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
        let entry = WidgetEntry(date: Date(), content: WidgetContent(title: "", subtitle: "", imageName: "", primaryContent: "", secondaryContent: "", count: "", updatedAt: ""))
        var entries: [WidgetEntry] = [entry]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
