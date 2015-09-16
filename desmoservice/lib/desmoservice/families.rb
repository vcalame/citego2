module Desmoservice
class Families
  include Enumerable
  
  attr_reader :url, :orphan_terms
  
  def initialize(url)
    @url = url
    @array = Array.new
    @orphan_members = Array.new
  end
  
  def parse_json(json_string)
    data = JSON.parse(json_string)
    if data.has_key?('familles')
      familles = data['familles']
      if familles.has_key?('familleArray')
        familles['familleArray'].each {|v| @array << Family.new(v)}
      end
      if familles.has_key?('sansfamille')
        familles['descripteurArray'].each {|v| @orphan_terms << Term.new(v)}
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