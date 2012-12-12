class AssignmentPresenter < BasePresenter
  presents :assignment

  def deadline
    "Deadline: #{ @object.deadline.strftime("%A, %B %d") }"
  end
end
