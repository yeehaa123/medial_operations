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

  def works_cited(references, title = "Works Cited")
    haml_tag :section, class: "bibliography" do
      haml_tag :h1, title
      haml_tag :ul do
        a = []
        references.each do |ref|
        # references.sort_by(&:author_list).each do |ref|
           present ref do |r|
            if a == ref.authors && a != []
              r.to_link(true)
            else
              r.to_link(false)
            end
            a = ref.authors
          end
        end
      end
    end
  end
end
