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

        var imagePadding: CGFloat {
            switch size {
            case .systemSmall:
                return 5
            default:
                return 4
            }
        }

        var body: some View {
            ZStack {
                Circle().fill(Color.black)
                Image("ToolList/\(imageName)")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.white)
                    .padding(imagePadding)
            }.frame(width: imageSize, height: imageSize)
        }
    }

    private struct SmallView: View {
        let content: WidgetContent

        var body: some View {
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    ToolListImage(imageName: content.imageName)
                    VStack(alignment: .leading) {
                        Text(verbatim: content.title)
                            .font(.headline)
                        Text(verbatim: content.subtitle)
                            .font(.subheadline)
                    }
                }
                Text(verbatim: content.primaryContent)
                Text(content.updatedAt)
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
            }
        }
    }

    private struct MediumView: View {
        let content: WidgetContent

        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        ToolListImage(imageName: content.imageName)
                        HStack {
                            Text(verbatim: content.title)
                                .font(.title2)
                            Text(verbatim: content.subtitle)
                                .font(.title3)
                        }
                    }
                    Text(verbatim: content.primaryContent)
                    if let text = content.secondaryContent {
                        Text(verbatim: text)
                    }
                    Text(content.updatedAt)
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
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
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Circle().fill(Color.orange))
        }
    }

    var body: some View {
        ZStack {
            ContainerRelativeShape()
               .inset(by: 4)
               .fill(Color.white)
            switch size {
            case .systemSmall:
                SmallView(content: content).padding()
            default:
                MediumView(content: content).padding()
            }
        }.background(Color.black)
    }
}

struct WidgetContentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetContentView(content: .mock)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        WidgetContentView(content: .mock)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
