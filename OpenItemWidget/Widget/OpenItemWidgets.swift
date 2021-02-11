import WidgetKit
import SwiftUI

@main
struct OpenItemWidget: Widget {
    static let widgetKind = WidgetKind.openItems
    let kind = Self.widgetKind.rawValue

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: OpenItemsIntent.self,
                            provider: OpenItemsIntentProvider(),
                            content: { WidgetContentView(content: $0.content) })
            .supportedFamilies([.systemSmall, .systemMedium])
// TODO: localized not working...
//            .configurationDisplayName(Self.widgetKind.displayName)
//            .description(Self.widgetKind.description)
            .configurationDisplayName("My Open Items")
            .description("Glance at your open Items from the current project")
        
    }
}

extension WidgetKind {
    var displayName: LocalizedStringKey {
        switch self {
        case .openItems:
            return "my_open_items_widget_display_name"
        }
    }

    var description: LocalizedStringKey {
        switch self {
        case .openItems:
            return "my_open_items_widget_description"
        }
    }
}
