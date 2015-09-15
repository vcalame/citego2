module Desmoservice
class Families
  include Enumerable
  
  attr_reader :url, :data, :orphan_members
  
  def initialize(url)
    @url = url
    @array = Array.new
    @orphan_members = Array.new
  end
  
  def self.download(desmoservice_conf, options = nil)
    url = build_json_url(desmoservice_conf, options)
    families = Families.new(url)
    json_string = open(url).read
    families.parse_json(json_string)
    return families
  end
  
  def self.build_json_url(desmoservice_conf, options = nil)
    default = {
      type: 'familles',
      fields: 'iddesc,libelles,attrs',
      fields_famille: nil,
      fields_descripteur: nil,
      selection_idctxt: nil,
      selection_code: nil,
      sansfamille: nil
    }
    if options
      options.delete('type')
      options.delete(:type)
      options = default.merge(options)
    else
      options = default
    end
    return desmoservice_conf.build_json_url(options)
  end
  
  def parse_json(json_string)
    data = JSON.parse(json_string)
    if data.has_key?('familles')
      familles = data['familles']
      if familles.has_key?('familleArray')
        familles['familleArray'].each {|v| @array << Family.new(v)}
      end
      if familles.has_key?('sansfamille')
        familles['descripteurArray'].each {|v| @orphan_members << Term.new(v)}
      end
    end
  end
  
  def each
    @array.each do |v|
      yield(v)
    end
  end
  
  def length
    return @array.length
  end
  
  def [](index)
    return @array[index]
  end

end
end