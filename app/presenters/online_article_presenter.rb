class OnlineArticlePresenter < MagazineArticlePresenter
  presents :online_article

  def to_mla(dup = false)
    s = ""
    s += authors(dup) if authors
    s += title if title
    s += publication_date if publication_date
    s += pages if pages
    s += medium if medium
    s += access_date if access_date
:A
    return s
  end
  alias_method :to_s, :to_mla

  private
  
    def title
      t = "\"#{ reference.title }.\" "
      t += content_tag :em, "#{ reference.website }"
      t += ". " unless t == ""
    end

    def publication_date
      if reference.publication_date && reference.startpage
        "#{ reference.publication_date.to_time.strftime("%e %b. %Y") }: "
      elsif reference.publication_date
        "#{ reference.publication_date.to_time.strftime("%e %b. %Y") }. "
      end
    end

    def access_date
      if reference.access_date
        "#{ reference.access_date.to_time.strftime("%e %b. %Y") }."
      end
    end

end
