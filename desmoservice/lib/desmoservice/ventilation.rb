module Desmoservice
class Ventilation
  
  attr_reader :url, :root, :sectors
  
  def initialize(url)
    @url = url
    @sectors = Array.new
  end
  
  def parse_json(json_string)
    data = JSON.parse(json_string)
    if data.has_key?('ventilation')
      ventilation = data['ventilation']
      if ventilation.has_key?('secteurArray')
        ventilation['secteurArray'].each {|v| @sectors << Sector.new(v)}
      end
      if ventilation.has_key?('root')
        @root  = Term.new(ventilation['root'])
      end
    end
  end
end

end