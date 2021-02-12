import Foundation

// COPY: WidgetHack.WidgetContentReaderWriter.swift

enum WidgetsAppGroup: String {
    case name = "group.com.procore.widgets"
}

// TODO: add unit tests
// TODO: add checks for current version when reading
final class WidgetContentReaderWriter {
    static let snapshotKey = "widget-snapshot"
    static let currentVersion: String = "1"

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
        // Do we have data?
        var storeData = readSnapshot()?.data ?? [kind: []]

        //Insert New Data into Store
        let newToolSnapshot = WidgetToolSnapshot(tool: tool, content: widgetContent)
        storeData[kind]?.insert(newToolSnapshot)

        //Generate New Store
        let updatedStore = WidgetStoreSnapshot(
            data: storeData,
            lastUpdated: Date(),
            versionNumber: Self.currentVersion)

        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(updatedStore)

        //Write New store to user defaults
        sharedContainer?.setValue(encodedData, forKey: Self.snapshotKey)
    }

    //Might need this if the user switches projects - otherwise our data store will need to get more complicated and group by project
    func clearAllContent() {
        
    }


}
