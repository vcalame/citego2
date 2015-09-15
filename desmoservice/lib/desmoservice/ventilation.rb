module Desmoservice
class Ventilation
  
  attr_reader :url, :sectors
  
  def initialize(url)
    @url = url
    @sectors = Array.new
  end
  
  def self.download(desmoservice_conf, options = nil)
    url = build_json_url(desmoservice_conf, options)
    ventilation = Ventilation.new(url)
    json_string = open(url).read
    ventilation.parse_json(json_string)
    return ventilation
  end
  
  def self.build_json_url(desmoservice_conf, options = nil)
    default = {
      type: 'ventilation',
      fields: 'iddesc,libelles,attrs',
      root_uri: nil,
      root_code: nil,
      fields_root: nil,
      fields_liaison: nil,
      fields_secteur: nil,
      ignore_empty: nil,
      famille_filter: nil
    }
    if options
      options.delete('type')
      options.delete(:type)
      options = default.merge(options)
    else
      options = default
    end
    if options[:ignore_empty]
      options["conf:ignore.empty.secteur"] = "true"
    elsif options[:ignore_empty].nil?
      options["conf:ignore.empty.secteur"] = "false"
    end
    if options[:famille_filter]
      options["conf:limitation.familles.idctxtarray"] = options[:famille_filter]
    end
    options.delete(:ignore_empty)
    options.delete(:famille_filter)
    return desmoservice_conf.build_json_url(options)
  end
  
  def parse_json(json_string)
    data = JSON.parse(json_string)
    if data.has_key?('ventilation')
      ventilation = data['ventilation']
      if ventilation.has_key?('secteurArray')
        ventilation['secteurArray'].each {|v| @sectors << Sector.new(v)}
      end
    end
  end
end

end