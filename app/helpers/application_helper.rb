module ApplicationHelper
  def format_datetime datetime
    return datetime.strftime("%m-%d-%Y")
  end

  def email_image_tag(image)
    return Rails.root.join("app/assets/images/#{image}")
  end
end
