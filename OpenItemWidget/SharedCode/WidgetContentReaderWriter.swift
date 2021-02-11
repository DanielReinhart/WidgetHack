import Foundation

// COPY: WidgetHack.WidgetContentReaderWriter.swift
final class WidgetContentReaderWriter {
    static let snapshotKey = "widget-snasphot"

    // TODO: use app group defaults
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

    func readContent(kind: WidgetKind, toolName: String) -> WidgetContent? {
//        guard let snapshot = readSnapshot()
//        else { return nil }
        return nil
    }


}
