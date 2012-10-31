class Chapter < IndividualReference 

  attr_accessible :monograph, :authors, :translators, :editors, :date,
                  :medium

  belongs_to :monograph
  delegate :authors, :publisher, :translators, :editors, :publication_date, 
           :medium, to: :monograph
end