# -*- encoding : utf-8 -*-
class Person
  include Cequel::Record
  has_many :heart_beats
  
  key :id, :uuid, auto: true
  column :name, :text
end
