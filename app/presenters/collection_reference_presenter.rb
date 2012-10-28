class CollectionReferencePresenter< ReferencePresenter
  presents :collection
  
  def title
    t = content_tag :em, collection
    t += ". " unless t == ""
  end
end