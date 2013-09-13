module ApplicationHelper
  def icon(name)
    content_tag(:i, " ", class: "icon-#{name.to_s.tr('_', '-')}")
  end
end
