module Desmoservice
class Get
  
  def initialize
  end
  
  def self.families(desmoservice_conf, get_params)
    options = get_params.to_h('familles')
    url = desmoservice_conf.build_json_url(options)
    families = Families.new(url)
    json_string = open(url).read
    families.parse_json(json_string)
    return families
  end
  
  def self.ventilation(desmoservice_conf, get_params)
    options = get_params.to_h('ventilation')
    url = desmoservice_conf.build_json_url(options)
    ventilation = Ventilation.new(url)
    json_string = open(url).read
    ventilation.parse_json(json_string)
    return ventilation
  end
  
  def self.word_distribution(desmoservice_conf, get_params)
    options = get_params.to_h('lexiedistribution')
    url = desmoservice_conf.build_json_url(options)
    word_distribution = WordDistribution.new(url)
    json_string = open(url).read
    word_distribution.parse_json(json_string)
    return word_distribution
  end
end

end