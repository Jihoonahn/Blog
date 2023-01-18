import Plot
import Publish

struct SectionItem: Component {
    var section: Publish.Section<Blog>
    var context: PublishingContext<Blog>
    
    var body: Component {
        switch section.path.string {
        case Blog.SectionID.blog.rawValue:
            return IndexPage(context: context, items: context.allItems(sortedBy: \.date, order: .descending)
                .filter{ $0.sectionID == .blog })
        case Blog.SectionID.about.rawValue:
            return AboutPage(section: section)
        default:
            return DefaultPage()
        }
    }
}
