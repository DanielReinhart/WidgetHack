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

    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry.mock
    }

    func getSnapshot(for configuration: OpenItemsIntent, in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        completion(WidgetEntry.mock)
    }

    func getTimeline(for configuration: OpenItemsIntent, in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        var entries: [WidgetEntry] = []
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
