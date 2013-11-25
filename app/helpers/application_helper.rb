module ApplicationHelper
  def display_url(url)
    url.starts_with?('http') ? url : "http://#{url}"
  end
end
