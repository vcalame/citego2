module Desmoservice
class Get
  
  def initialize
  end
  
  def self.families(desmoservice_conf, get_params, http=nil)
    options = get_params.to_h('familles')
    uri = desmoservice_conf.build_json_uri(options)
    if http.nil?
      json_string = Net::HTTP.get(uri)
    else
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      json_string = response.body
    end
    families = Families.new()
    families.parse_json(json_string)
    return families
  end
  
  def self.ventilation(desmoservice_conf, get_params, http=nil)
    options = get_params.to_h('ventilation')
    uri = desmoservice_conf.build_json_uri(options)
    if http.nil?
      json_string = Net::HTTP.get(uri)
    else
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      json_string = response.body
    end
    ventilation = Ventilation.new()
    ventilation.parse_json(json_string)
    return ventilation
  end
  
  def self.word_distribution(desmoservice_conf, get_params, http=nil)
    options = get_params.to_h('lexiedistribution')
    uri = desmoservice_conf.build_json_uri(options)
    if http.nil?
      json_string = Net::HTTP.get(uri)
    else
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      json_string = response.body
    end
    word_distribution = WordDistribution.new()
    word_distribution.parse_json(json_string)
    return word_distribution
  end
end

end