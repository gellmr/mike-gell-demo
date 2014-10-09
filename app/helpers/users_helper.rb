module UsersHelper

  def tab_class(page_name)
    if page_name.eql? controller_name
      'active'
    else
      ''
    end
  end

  def navtab_li(page_name)
    open_tag = true
    tag_options = {class: tab_class(page_name)}
    tag("li", tag_options, open_tag)
  end
end
