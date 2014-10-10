module UsersHelper

  def tab_class(actn)
    if actn.eql? "#{controller_name}/#{action_name}"
      'active'
    else
      ''
    end
  end

  def navtab_li(actn)
    #logger.debug "actn: #{actn} action_name: #{action_name} controller_name:#{controller_name}"
    open_tag = true
    tag_options = {class: tab_class(actn)}
    tag("li", tag_options, open_tag)
  end
end
