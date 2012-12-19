class CollectionReference < Reference

  attr_accessible :medium

  field   :medium, type: String

  private

   def editor(editors)
     if editors
       editors = parse_editors(editors)
       self.editors << set_editors(editors)
     end
   end    
end
