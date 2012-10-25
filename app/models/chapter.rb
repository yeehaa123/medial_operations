class Chapter < IndividualReference 

  attr_accessible :pages, :monograph, :authors, :translators, :editors, :date,
                  :medium

  field   :pages, type: String

  belongs_to :monograph
  delegate :authors, :publisher, :translators, :editors, :publication_date, 
           :medium, to: :monograph
end