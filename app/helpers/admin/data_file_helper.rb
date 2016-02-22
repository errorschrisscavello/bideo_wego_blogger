module Admin::DataFileHelper
  def data_fileable_link_for(data_file)
    data_fileable = data_file.data_fileable
    if data_file.data_fileable.is_a?(View)
      resource = data_fileable.viewable
      type = data_fileable.viewable.class.to_s
      text = data_fileable.viewable.title
    else
      resource = data_fileable
      type = data_fileable.class.to_s
      text = data_fileable.name
    end
    "#{type} - #{link_to(text, polymorphic_path([:admin, resource]))}".html_safe
  end
end
