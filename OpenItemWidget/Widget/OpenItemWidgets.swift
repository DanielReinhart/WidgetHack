import WidgetKit
import SwiftUI

@main
struct OpenItemWidget: Widget {
    let kind = WidgetKind.openItems.rawValue

    private var provider: OpenItemsIntentProvider {
        OpenItemsIntentProvider()
    }

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: OpenItemsIntent.self,
                            provider: provider,
                            content: { WidgetContentView(content: $0.content) })
            .supportedFamilies([.systemSmall, .systemMedium])
            .configurationDisplayName("My Widget")
            .description("This is an example widget.")
    }
}
