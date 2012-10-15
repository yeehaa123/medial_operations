class SectionPresenter < BasePresenter
  presents :section

  def heading
    "#{ roman_numeral } - #{ @object.title }"
  end
end