import WidgetKit
import SwiftUI

@main
struct OpenItemWidget: Widget {
    static let widgetKind = WidgetKind.openItems
    let kind = Self.widgetKind.rawValue

    private var provider: WidgetContentProvider {
        WidgetContentProvider(kind: Self.widgetKind)
    }

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: provider,
            content: { WidgetContentView(content: $0.content) })
            .supportedFamilies([.systemSmall, .systemMedium])
            .configurationDisplayName(Self.widgetKind.displayName)

    }
}


extension WidgetKind {
    var displayName: String {
        switch self {
        case .openItems:
            return NSLocalizedString(
                "My Open Items",
                comment: "My Open Items widget display name")
        }
    }
}
