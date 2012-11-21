class ReferencePresenter < BasePresenter
  presents :reference

  def to_mla(dup = false)
    s = ""
    s += authors(dup) if authors
    s += title if title
    s += editors if editors
    s += translators if translators
    s += publication_date if publication_date
    return s
  end
  alias_method :to_s, :to_mla

  def to_link(dup = false)
    haml_tag :li, link_to(raw(to_mla(dup)), reference_path(reference._slugs))
  end 

  def author_list
    reference.authors.map do |a|
      link_to a, a
    end.join('. ')
  end
  
  def profile
    haml_tag :p, author_list if authors
  end
  
  private
    def authors(dup = false)
      if dup
        al = "---. "
      else
        if reference.authors 
          al = ""
          reference.authors.each_with_index do |a, i|
            if i == 0
              al += "#{ a }"
            elsif i > 0 && reference.authors.size == 2
              al += " and #{ a.full_name }"
            elsif i > 0 && i < reference.authors.size - 1
              al += ", #{ a.full_name }"
            else
              al += ", and #{ a.full_name }"
            end
          end
          al += ". " unless al == ""
        end
      end
      al
    end
    
    def title
      "\"#{ reference }.\" "
    end

    def editors
      if reference.editors.size > 0
        s = ""
        reference.editors.each_with_index do |e, i|
          if i == 0
            s += "Ed. #{ e.full_name }"
          elsif i > 0
            s += " and #{ e.full_name }"
          end
        end
        s += ". " unless s == ""
      end
      s
    end

    def translators
      if reference.translators.size > 0
        s = ""
        reference.translators.each_with_index do |t, i|
          if i == 0
            s += "Trans. #{ t.full_name }"
          elsif i > 0
            s += " and #{ t.full_name }"
          end
        end
        s += ". " unless s == ""
      end
    end

    def publisher
      "#{ reference.publisher }, " if reference.publisher
    end

    def pages
      if reference.respond_to?(:startpage)
        if reference.startpage && reference.endpage
          "#{ reference.startpage }-#{ reference.endpage }. "
        end
      end
    end


    def publication_date
      if reference.publication_date
        "#{ reference.publication_date.to_time.strftime("%Y") }. "
      end
    end

    def medium
      "#{ reference.medium.capitalize }." if reference.medium
    end
end
