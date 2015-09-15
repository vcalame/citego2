module Desmoservice

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

end