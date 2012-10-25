class ReferencePresenter < BasePresenter
  presents :reference

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
    t = "\"#{ reference }.\" "
    if reference.respond_to?(:journal)
      t += content_tag :em, "#{ reference.journal }"
    elsif reference.respond_to?(:magazine)
      t += content_tag :em, "#{ reference.magazine }"
    end
    t += ". " unless t == ""
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
    if reference.respond_to?(:magazine)
      if reference.publication_date
        "#{ reference.publication_date.strftime("%e %b. %Y") }: "
      end
    else
      if reference.publication_date
        "#{ reference.publication_date.strftime("%Y") }. "
      end
    end
  end

  def medium
    if reference.respond_to?(:monograph)
      "#{ reference.monograph.medium.capitalize }." if reference.monograph.medium
    elsif reference.respond_to?(:journal)
      "#{ reference.journal.medium.capitalize }." if reference.journal.medium
    else
      "#{ reference.medium.capitalize }." if reference.medium
    end
  end

  def to_mla(dup = false)
    s = ""
    s += authors(dup) if authors
    s += title if title
    # s += volume_issue if volume_issue
    s += editors if editors
    s += translators if translators
    s += publisher if publisher
    s += publication_date if publication_date
    s += pages if pages
    s += medium if medium
  end
  alias_method :to_s, :to_mla

  def to_link(dup = false)
    haml_tag :li, link_to(raw(to_mla(dup)), reference_path(reference._id))
  end
end