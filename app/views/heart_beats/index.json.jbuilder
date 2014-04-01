json.array!(@heart_beats) do |heart_beat|
  json.extract! heart_beat, :id, :heart_beat, :intensity
  json.url heart_beat_url(heart_beat, format: :json)
end
