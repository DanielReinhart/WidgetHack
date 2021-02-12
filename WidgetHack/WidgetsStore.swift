import Foundation
import WidgetKit

//"Open Items" : { "Punch": WidgetContent, "Correspondence": WidgetContent }
@available(iOS 14.0, *)
final class WidgetsStore {
    private var registeredWidgetKinds: Set<WidgetKind> = []
    //TODO: inject a sensible defaults on init?
    private var snapshot: WidgetStoreSnapshot = .init(data: [:], lastUpdated: Date(), versionNumber: "0")

    // for telemetry
    func register(kind: WidgetKind) {
        registeredWidgetKinds.insert(kind)
    }

    func reload(kind: WidgetKind, tool: WidgetTool, content: WidgetContent) {
        // TODO: write to telemetry?, whenever the content changes
        snapshot = snapshot.with(kind: kind, tool: tool, content: content)
        print("Store Did Reload 👍")
        print(snapshot)
        // TODO: throtle the producer to avoid penalty by WidgetKit?
        do {
            try WidgetContentReaderWriter()
                .writeSnapshot(kind: kind, tool: tool, widgetContent: content)
            WidgetCenter.shared.reloadTimelines(ofKind: kind.rawValue)
        } catch {
            //Assertion???
            print("error")
        }

    }
}

private extension WidgetStoreSnapshot {
    func with(kind: WidgetKind, tool: WidgetTool, content: WidgetContent) -> Self {
        var snapshots = data[kind] ?? []
        if let toolSnapshot = snapshots.first(where: { $0.tool == tool }) {
            snapshots.remove(toolSnapshot)
            snapshots.insert(WidgetToolSnapshot(tool: tool, content: content))
        } else {
            snapshots.insert(WidgetToolSnapshot(tool: tool, content: content))
        }
        var modifiedData = data
        modifiedData[kind] = snapshots
        return Self(
            data: modifiedData,
            lastUpdated: Date(),
            versionNumber: versionNumber)
    }
}

