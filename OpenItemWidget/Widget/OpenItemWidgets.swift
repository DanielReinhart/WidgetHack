import WidgetKit
import SwiftUI

@main
struct OpenItemWidget: Widget {
    let kind = WidgetKind.openItems.rawValue

    private var provider: OpenItemsProvider {
        OpenItemsProvider()
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: provider,
            content: { WidgetContentView(content: $0.content) })
            .supportedFamilies([.systemSmall, .systemMedium])
            .configurationDisplayName("My Widget")
            .description("This is an example widget.")
    }
}
