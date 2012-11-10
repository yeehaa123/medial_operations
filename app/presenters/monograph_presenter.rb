class MonographPresenter < CollectionReferencePresenter
  presents :monograph

  def to_mla(dup = false)
    s = ""
    s += authors(dup) if authors
    s += title if title
    s += editors if editors
    s += translators if translators
    s += publisher if publisher
    s += publication_date if publication_date
    s += medium if medium
    return s
  end
  alias_method :to_s, :to_mla

  def title
    "<em>#{ reference.title }</em>. "
  end
end