module Desmoservice

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

end