struct BaseLayout: HTMLConvertable {
    var location: Location
    var context: PublishingContext<Blog>
    var component: () -> Component

    public init(
        for location: Location,
        context: PublishingContext<Blog>,
        component: @escaping () -> Component
    ) {
        self.location = location
        self.context = context
        self.component = component
    }
    
    func build() -> HTML {
        HTML(
            .head(for: location, context: context),
            .body {
                Header(context: context)
                Main {
                    component()
                }
                .id("main")
                .class("relative z-10 flex flex-1 flex-col min-h-screen pb-14")
                Footer(context: context)
            }
        )
    }
}
