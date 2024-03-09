module ApplicationHelper
  def flash_color_type(type)
    case type.to_sym
    when :notice then "bg-green-100 border-green-500 text-green-700"
    when :alert then "bg-red-100 border-red-500 text-red-700"
    else "bg-gray-100 border-gray-500 text-gray-700"
    end
  end
end
