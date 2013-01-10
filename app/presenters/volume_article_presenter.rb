class VolumeArticlePresenter < ReferencePresenter
  presents :volume_article

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

  private
    def title
      t = "\"#{ reference.title }.\" "
      t += content_tag :em, "#{ reference.volume }"
      t += ". " unless t == ""
    end
end
