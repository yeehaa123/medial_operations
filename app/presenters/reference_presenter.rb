class ReferencePresenter < BasePresenter
  presents :reference

  def to_link(dup = false)
    haml_tag :li, link_to(raw(to_mla(dup)), reference_path(reference._id))
  end

  private
    def authors(dup = false)
      if dup
        al = "---. "
      else
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
      al
    end
    
    def title
      "\"#{ reference }.\" "
    end

    def editors
      if reference.editors
        s = ""
        reference.editors.each_with_index do |t, i|
          if i == 0
            s += "Ed. #{ t.full_name}"
          elsif i > 0
            s += " and #{t.full_name}"
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
      if reference.respond_to?(:pages)
        "#{ reference.pages }. " if reference.pages
      end
    end


    def publication_date
      if reference.publication_date
        "#{ reference.publication_date.strftime("%Y") }. "
      end
    end

    def medium
      "#{ reference.medium.capitalize }." if reference.medium
    end
end