//
//  OpenItemWidget.swift
//  OpenItemWidget
//
//  Created by Daniel Reinhart on 2/10/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetContentEntry {
        WidgetContentEntry(date: Date(), content: WidgetContent.mock)
    }

    func getSnapshot(in context: Context, completion: @escaping (WidgetContentEntry) -> ()) {
        let entry = WidgetContentEntry(date: Date(), content: WidgetContent.mock)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [WidgetContentEntry(date: Date(), content: WidgetContent.mock)], policy: .atEnd)
        completion(timeline)
    }
}



struct WidgetContentEntry: TimelineEntry {
    let date: Date
    let content: WidgetContent
}

struct OpenItemWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

@main
struct OpenItemWidget: Widget {
    let kind: String = "OpenItemWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            OpenItemWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct OpenItemWidget_Previews: PreviewProvider {
    static var previews: some View {
        OpenItemWidgetEntryView(entry: WidgetContentEntry(date: Date(), content: WidgetContent.mock))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
