# -*- encoding : utf-8 -*-
class HeartBeat
  include Cequel::Record
  include CequelConcern
  belongs_to :person

  key :id, :uuid, auto: true
  column :heart_beat, :timestamp
  column :intensity, :int

end
