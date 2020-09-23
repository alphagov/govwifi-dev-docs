class Manual
  attr_reader :sitemap

  def initialize(sitemap)
    @sitemap = sitemap
  end

  def manual_pages_grouped_by_section
    grouped = manual_pages
        .group_by { |page| page.data.section || "Uncategorised" }
        .sort_by { |group| group.first.downcase }

    [["Common tasks", most_important_pages]] + grouped
  end

  private

  def most_important_pages
    manual_pages.select { |page| page.data.important }
  end

  def manual_pages
    sitemap.resources
        .select { |page| page.path.start_with?("manual/") && page.path.end_with?(".html") && page.data.title }
  end
end
