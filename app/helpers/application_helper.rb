module ApplicationHelper
  def present(object, klass = nil)
    klass ||= "#{ object.class }Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def markdown(text)
    Kramdown::Document.new(text).to_html.html_safe
  end
end