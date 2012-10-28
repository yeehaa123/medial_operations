class MagazineArticlePresenter < ReferencePresenter
  presents :magazine_article
  
  def title
    t = "\"#{ reference }.\" "
    t += content_tag :em, "#{ reference.magazine }"
    t += ". " unless t == ""
  end

  def publication_date
    if reference.publication_date && reference.pages
      "#{ reference.publication_date.strftime("%e %b. %Y") }: "
    elsif reference.publication_date
      "#{ reference.publication_date.strftime("%e %b. %Y") }. "
    end
  end

  def to_mla(dup = false)
    s = ""
    s += authors(dup) if authors
    s += title if title
    s += publication_date if publication_date
    s += pages if pages
    s += medium if medium
  end
  alias_method :to_s, :to_mla
end
