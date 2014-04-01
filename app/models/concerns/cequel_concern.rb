module CequelConcern
    extend ActiveSupport::Concern
    #This is because uuids will not get correctly seralized
    def read_attribute_for_serialization(n)
      n == "id" ? attributes[n].to_s : attributes[n]
    end
    
    def to_param
      self.id.to_s
    end
end