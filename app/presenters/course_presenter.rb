class CoursePresenter < BasePresenter
  presents :course
  
  def prerequisites
    if @object.prerequisites
      markdown(@object.prerequisites)
    end
  end

  def requirements
    if @object.requirements
      markdown(@object.requirements)
    end
  end
end
