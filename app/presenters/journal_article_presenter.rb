class JournalArticlePresenter < ReferencePresenter
  presents :journal_article
  
  def to_mla(dup = false)
    s = ""
    s += authors(dup) if authors
    s += title if title
    s += volume_issue if volume_issue
    s += publication_date if publication_date
    s += pages if pages
    s += medium if medium
    return s
  end
  alias_method :to_s, :to_mla
  
  private

    def title
      t = "\"#{ reference }.\" "
      t += content_tag :em, "#{ reference.journal }"
      t += ". " unless t == ""
    end

    def publication_date
      if reference.publication_date && reference.pages
        "(#{ reference.publication_date.strftime("%Y") }): "
      elsif reference.publication_date
        "(#{ reference.publication_date.strftime("%Y") }). "
      end
    end

    def volume_issue
      if reference.volume && reference.issue
        "#{ reference.volume }.#{ reference.issue } "
      end
    end
end