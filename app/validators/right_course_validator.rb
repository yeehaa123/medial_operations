class RightCourseValidator < ActiveModel::Validator
  def self.kind()
    :custom
  end
  def validate(record)
    unless record.section.course_id == record.course_id
      record.errors[:section] << 'section needs to belong to same course'
    end
  end
end
