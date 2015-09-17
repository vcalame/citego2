module Desmoservice

class Sector < Term
  
  attr_reader :subsectors, :members
  
  def initialize(data)
    super(data['terme'])
    @members = Array.new
    if data.has_key?('liaisonArray')
      data['liaisonArray'].each {|v| @members << SectorTerm.new(v)}
    end
  end
  
end

class SectorTerm < Term
  
  attr_reader :position
  
  def initialize(data)
    super(data['terme'])
    @position = data['position']
  end
  
end

end