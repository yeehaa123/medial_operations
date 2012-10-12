class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  def method_missing(*args, &block)
    @template.send(*args, &block)
  end

  def h
    @template
  end

  def heading
    @object.to_s
  end

  def description
    if @object.description
      markdown(@object.description)
    end
  end
end