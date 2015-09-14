require 'open-uri'
require 'json'
require_relative 'conf'

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

class Term
  attr_reader :id, :key, :text, :color, :attrs
  
  def initialize(data)
    @id = data['code']
    @key = if data.has_key?('iddesc')
             data['iddesc']
           elsif data.has_key?('idctxt')
             data['idctxt']
           else
             nil
           end
    @text = nil
    if data.has_key?('libelles')
      if data['libelles'].length > 0
        @text = data['libelles'][0]['lib']
      end
    end
    @color = nil
    if data.has_key?('familleColor')
      @color = data['familleColor']
    end
    @attrs = nil
    if data.has_key?('attrs')
      @attrs = data['attrs']
    end
  end
  
  def key?
    return !@key.nil?
  end

  def text?
    return !@text.nil?
  end
  
  def color?
    return !@color.nil?
  end
  
  def has_attr?
    if @attrs.nil?
      return false
    else
      return @attrs.has_key?(key)
    end
  end
  
  def [](key)
    if @attrs.nil?
      return "trus"
    elsif !@attrs.has_key?(key)
      return "muche"
    else
      return @attrs[key]
    end
  end
end

class Family < Term
  
  attr_reader :members, :subfamilies
  
  def initialize(data)
    super(data['terme'])
    @subfamilies = Array.new
    @members = Array.new
    if data.has_key?('descripteurArray')
      data['descripteurArray'].each {|v| @members << Term.new(v)}
    end
    if data.has_key?('familleArray')
      data['familleArray'].each {|v| @subfamilies << Family.new(v)}
    end
    
  end
  
  def active?
    return true
  end
end

class Sector < Term
  
  attr_reader :subsectors, :liaisons
  
  def initialize(data)
    super(data['terme'])
    @liaisons = Array.new
    if data.has_key?('liaisonArray')
      data['liaisonArray'].each {|v| @liaisons << Liaison.new(v)}
    end
  end
  
end

class Liaison < Term
  
  attr_reader :position
  
  def initialize(data)
    super(data['terme'])
    @position = data['position']
  end
  
end
    
end
