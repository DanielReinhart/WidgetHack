//
//  OpenItemsIntentProvider.swift
//  OpenItemWidgetExtension
//
//  Created by Daniel Reinhart on 2/11/21.
//

import Foundation
import WidgetKit

class OpenItemsIntentProvider: IntentTimelineProvider {
    typealias Entry = WidgetEntry
    typealias Intent = OpenItemsIntent

    static let widgetKind = WidgetKind.openItems

    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(date: Date(), content: .placeholder)
    }

    func getSnapshot(for configuration: OpenItemsIntent, in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let entry = makeEntry(context: context, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: OpenItemsIntent, in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        let entry = makeEntry(context: context, configuration: configuration)
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

private extension OpenItemsIntentProvider {
    func makeEntry(context: Context, configuration: OpenItemsIntent) -> WidgetEntry {
        let content = makeContent(context: context, configuration: configuration)
        return WidgetEntry(date: Date(), content: content)
    }

    func makeContent(context: Context, configuration: OpenItemsIntent) -> WidgetContent {
        if context.isPreview {
            return .placeholder
        } else if let content = readContent(configuration: configuration) {
            return content
        } else {
            return .makeEmptyState(tool: configuration.tool.widgetTool)
        }
    }

    func readContent(configuration: Intent) -> WidgetContent? {
        guard let tool = configuration.tool.widgetTool
        else { return nil }
        return WidgetContentReaderWriter()
            .readContent(kind: Self.widgetKind, tool: tool)
    }
}
