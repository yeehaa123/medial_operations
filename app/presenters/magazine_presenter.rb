class MagazinePresenter < CollectionReferencePresenter
  presents :magazine

  def name
    t = content_tag :em, "#{ reference }"    
    t += ". " unless t == ""
  end

  def to_mla(dup = false)
    s = ""
    s += name if name
  end
  alias_method :to_s, :to_mla
end