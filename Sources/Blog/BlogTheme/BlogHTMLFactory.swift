import Publish
import Plot

struct BlogHTMLFactory: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Blog>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .homeheader(for: context.site),
                .wrapper(
                    .posts(
                        for: context.allItems(
                            sortedBy: \.date,
                            order: .descending),
                        on: context.site,
                        context: context
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makeSectionHTML(for section: Section<Blog>, context: PublishingContext<Blog>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .header(for: context.site),
                .wrapper(
                    
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makeItemHTML(for item: Item<Blog>, context: PublishingContext<Blog>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .header(for: context.site, class: "site-header-dark"),
                .wrapper(
                    .post(for: item, on: context.site)
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makePageHTML(for page: Page, context: PublishingContext<Blog>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .header(for: context.site),
                .wrapper(
                    .page(for: page, context: context)
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Blog>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .header(for: context.site),
                .wrapper(
                    .tagListPage(for: page, context: context)
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Blog>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: context.site),
            .body(
                .header(for: context.site),
                .wrapper(
                    .posts(for: context.items(
                        taggedWith: page.tag,
                        sortedBy: \.date,
                        order: .descending
                    ),
                    on: context.site,
                    context: context)
                ),
                .footer(for: context.site)
            )
        )
    }
}
