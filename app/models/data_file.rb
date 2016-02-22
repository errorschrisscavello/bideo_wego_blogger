class DataFile < ActiveRecord::Base
  belongs_to :file_type
  belongs_to :data_fileable, :polymorphic => true


  def partials
    partial_names = body.scan(/\{% partial .?(\w+).?/).flatten
    Partial.where('name IN [?]', partial_names)
  end


  def render(data={})
    rendered = file_type.markdown? ? RDiscount.new(body).to_html : body
    rendered = file_type.liquid? ? Liquid::Template.parse(rendered).render(data) : rendered
    rendered.html_safe
  end
end
