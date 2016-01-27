module ApplicationHelper
  def error_messages_for(object, field=nil)
    errors = field ? object.errors[field] : object.errors.full_messages
    errors.each do |error|
      yield(error)
    end 
  end


  def fa(*args)
    classes = args.map { |arg| "fa-#{arg}" }.join(' ')
    %Q[<i class="fa #{classes}"></i>].html_safe
  end
end

