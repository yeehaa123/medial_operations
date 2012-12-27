class PeriodicalReference < IndividualReference
  attr_accessible :volume, :number

  field :volume, type: Integer
  field :issue, type: Integer

  def medium=(medium = "Print")
    self.periodical.update_attributes(medium: medium)
  end


  private
   
    def periodical_name(periodical)
      self.periodical = Periodical.find_or_create_by(name: periodical)
    end

    def volume(volume)
      self.volume = volume
    end

    def issue(issue)
      self.issue = issue
    end

    def article_title(title)
      self.title = title.delete(".")
    end
end
