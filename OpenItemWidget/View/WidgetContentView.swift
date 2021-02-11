import WidgetKit
import SwiftUI

struct WidgetContentView: View {
    @Environment(\.widgetFamily) var size
    let content: WidgetContent

    private struct ToolListImage: View {
        @Environment(\.widgetFamily) var size
        let imageName: String

        var imageSize: CGFloat {
            switch size {
            case .systemSmall:
                return 28
            default:
                return 32
            }
        }

        var body: some View {
            Image("ToolList/\(imageName)")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.primary)
                .frame(width: imageSize, height: imageSize)
                .unredacted()
        }
    }

    private struct SmallView: View {
        let content: WidgetContent

        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    if let name = content.imageName {
                        ToolListImage(imageName: name).unredacted()
                    }
                    Text(verbatim: content.title)
                        .font(.headline)
                }
                Text(verbatim: content.subtitle)
                    .font(.subheadline)
                Text(verbatim: content.primaryContent)
                if let timestamp = content.updatedAt {
                    Text(timestamp)
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .padding(.top, 2)
                }
            }
        }
    }

    private struct MediumView: View {
        let content: WidgetContent

        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        if let name = content.imageName {
                            ToolListImage(imageName: name)
                        }
                        Text(verbatim: content.title)
                            .font(.title)
                    }
                    Text(verbatim: content.subtitle)
                    Text(verbatim: content.primaryContent)
                    if let text = content.secondaryContent {
                        Text(verbatim: text)
                    }
                    if let timestamp = content.updatedAt {
                        Text(timestamp)
                            .font(.footnote)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                    }
                }
                Spacer()
                if let value = content.count {
                    CountView(value: value)
                }
            }
        }
    }

    private struct CountView: View {
        let value: String

        var body: some View {
                Text(verbatim: value)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Circle().fill(Color.orange))
        }
    }

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(Color.white)
            switch size {
            case .systemSmall:
                SmallView(content: content).padding(2)
            default:
                MediumView(content: content).padding(8)
            }
        }
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetContentView(content: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        WidgetContentView(content: .placeholder)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        WidgetContentView(content: .emptyState)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        WidgetContentView(content: .emptyState)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
