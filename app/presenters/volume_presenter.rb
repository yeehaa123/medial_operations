class VolumePresenter < CollectionReferencePresenter
  presents :volume

  def to_mla(dup = false)
    s = ""
    s += editors(dup) if authors
    s += title if title
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

  def editors(dup = false)
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
        al += ", et al." if reference.many_authors?
        if reference.authors.size > 2
          al += ", eds"
        else
          al += ", ed"
        end
        al += ". " unless al == ""
      end
    end
    al
  end
end
