class MagazineArticlePresenter < ReferencePresenter
  presents :magazine_article
    
  def to_mla(dup = false)
    s = ""
    s += authors(dup) if authors
    s += title if title
    s += publication_date if publication_date
    s += pages if pages
    s += medium if medium
    return s
  end
  alias_method :to_s, :to_mla

  private
  
    def title
      t = "\"#{ reference.title }.\" "
      t += content_tag :em, "#{ reference.magazine }"
      t += ". " unless t == ""
    end

    def publication_date
      if reference.publication_date && reference.startpage
        "#{ reference.publication_date.to_time.strftime("%e %b. %Y") }: "
      elsif reference.publication_date
        "#{ reference.publication_date.to_time.strftime("%e %b. %Y") }. "
      end
    end
end
