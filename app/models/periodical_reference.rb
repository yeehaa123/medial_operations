class PeriodicalReference < IndividualReference
  attr_accessible :volume, :number

  field :volume, type: Integer
  field :issue, type: Integer
end