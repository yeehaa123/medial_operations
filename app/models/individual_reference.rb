class IndividualReference < Reference
  attr_accessible :startpage, :endpage

  field   :startpage, type: Integer
  field   :endpage, type: Integer
end
