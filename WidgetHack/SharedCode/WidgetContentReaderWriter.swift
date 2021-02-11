import Foundation

// COPY: WidgetHack.WidgetContentReaderWriter.swift
final class WidgetContentReaderWriter {
    static let snapshotKey = "widget-snasphot"

    var sharedContainer: UserDefaults? {
        UserDefaults(suiteName: WidgetsAppGroup.name.rawValue)
    }

    func readSnapshotData() -> Data? {
        sharedContainer?.data(forKey: Self.snapshotKey)
    }

    func readSnapshot() -> WidgetStoreSnapshot? {
        guard let data = readSnapshotData()
        else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(WidgetStoreSnapshot.self, from: data)
    }

    func readContent(kind: WidgetKind, tool: WidgetTool) -> WidgetContent? {
        guard let snapshot = readSnapshot()
        else { return nil }
        return snapshot.contentBy(kind: kind, tool: tool)
    }

    func writeSnapshot(kind: WidgetKind, tool: WidgetTool, widgetContent: WidgetContent) throws {
        //Get data out from store
        guard var storeData = readSnapshot()?.data else {
            throw NSError(domain: "widgets", code: 1, userInfo: nil)
        }

        //Insert New Data into Store
        let newToolSnapshot = WidgetToolSnapshot(tool: tool, content: widgetContent)
        storeData[kind.rawValue]?.insert(newToolSnapshot)

        //Generate New Store
        let updatedStore = WidgetStoreSnapshot(data: storeData, lastUpdated: Date(), versionNumber: "1")

        //Write New store to user defaults
        sharedContainer?.setValue(updatedStore, forKey: Self.snapshotKey)
    }


}
