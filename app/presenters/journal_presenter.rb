class JournalPresenter < CollectionReferencePresenter
  presents :magazine

  def name
    t = content_tag :em, "#{ magazine }"    
    t += ". " unless t == ""
  end

  def publisher
    "#{ reference.publisher }. " if reference.publisher
  end

  def to_mla(dup = false)
    s = ""
    s += name if name
  end
  alias_method :to_s, :to_mla
end