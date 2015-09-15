module Desmoservice

class Liaison < Term
  
  attr_reader :position
  
  def initialize(data)
    super(data['terme'])
    @position = data['position']
  end
  
end

end