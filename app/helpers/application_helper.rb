module ApplicationHelper
  
  # Alert classes used with Bootstrap.
  def flash_class(level)
    case level
      when :success then "alert alert-success"
      when :info then "alert alert-info"
      when :warning then "alert alert-warning"
      when :danger then "alert alert-danger"
      else false
    end
  end
  
end
