require 'open-uri'
require 'json'
require_relative 'conf'

module Desmoservice
class Familles
  include Enumerable
  
  attr_reader :url, :data, :array, :sansfamille
  
  def initialize(url)
    @url = url
    @array = Array.new
  end
  
  def self.download(desmoservice_conf, options = nil)
    url = build_json_url(desmoservice_conf, options)
    familles = Familles.new(url)
    json_string = open(url).read
    familles.parse_json(json_string)
    return familles
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
    @data = JSON.parse(json_string)
    if @data.has_key?('familles')
      familles = @data['familles']
      if familles.has_key?('familleArray')
        familles['familleArray'].each {|v| @array << Famille.new(v)}
      end
      if familles.has_key?('sansfamille')

      end
    end
  end
  
  def each
    @array.each do
      yield
    end
  end
  
  def length
    return @array.length
  end
  
  def [](index)
    return @array[index]
  end

end

class Famille
  
  attr_reader :code, :descripteurs, :children, :text, :idctxt
  
  def initialize(data)
    terme = data['terme']
    @code = terme['code']
    @idctxt =terme['idctxt']
    @children = Array.new
    @descripteurs = Array.new
    if data.has_key?('descripteurArray')
      data['descripteurArray'].each {|v| @descripteurs << Descripteur.new(v)}
    end
    if data.has_key?('familleArray')
      data['familleArray'].each {|v| @children << Famille.new(v)}
    end
    
  end
  
  def active?
    return true
  end
end

class Descripteur
  
  attr_reader :code, :iddesc, :text
  
  def initialize(data)
    @code = data['code']
    @iddesc = data['iddesc']
    @text = nil
    if data.has_key?('libelles')
      if data['libelles'].length > 0
        @text = data['libelles'][0]['lib']
      end
    end
  end
end


class Terme
  
  def self.get_color(terme_data)
    
  end
end
    
end
