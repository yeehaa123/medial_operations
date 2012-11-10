class PresentationsController < ApplicationController
  expose(:presentations) { Presentation.all}
  expose(:presentation)
end
