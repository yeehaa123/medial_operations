class IndividualReference < Reference
  attr_accessible :startpage, :endpage

  field   :startpage, type: Integer
  field   :endpage, type: Integer
    
  private
    def pages(pages)
      pages = pages.split("-").map { |m| m.to_i }
      self.startpage = pages[0]
      self.endpage = pages[1]
    end
end
