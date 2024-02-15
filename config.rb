require 'govuk_tech_docs'

set :relative_links, true

configure :build do
  activate :relative_assets
end

GovukTechDocs.configure(self)

helpers do
  def format_date(date)
    if date.is_a?(Date)
      date.strftime("%-e %B %Y")
    else
      Date.parse(date).strftime("%-e %B %Y")
    end
  end
end
