class ChapterPresenter < ReferencePresenter
  presents :chapter

  def title
    t = "\"#{ chapter }.\" "
    t += content_tag :em, "#{ chapter.monograph }"
    t += ". " unless t == ""
  end
  
  def to_mla(dup = false)
    s = ""
    s += authors(dup) if authors
    s += title if title
    s += editors if editors
    s += translators if translators
    s += publisher if publisher
    s += publication_date if publication_date
    s += pages if pages
    s += medium if medium
  end
  alias_method :to_s, :to_mla
end