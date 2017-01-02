module ApplicationHelper
  
  # Alert classes used with Bootstrap.
  def flash_class(level)
    case level
      when :success then "alert alert-success"
      when :info then "alert alert-info"
      when :notice then "alert alert-info"
      when :warning then "alert alert-warning"
      when :danger then "alert alert-danger"
      else false
    end
  end

  def navigation_li(text, path, link_attribs={})
    active_class = path == request.path ? 'active' : ''
    tag = content_tag :li, class: "#{active_class}" do
      link_to text, path, link_attribs
    end
    return tag
  end
end
