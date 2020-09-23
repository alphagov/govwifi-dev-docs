require 'govuk_tech_docs'
require_relative "./app/manual"

GovukTechDocs.configure(self)

helpers do
  def manual
    Manual.new(sitemap)
  end
end
