class BaseParser
  attr_accessor :object  
  
  def description(d)
    object.description = d.css('h4 ~ *').to_html
  end

  def references(r)
    r.css('p').each do |reference|
      object.reference(reference.to_html)
    end
  end
 end
