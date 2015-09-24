class TransfertLiensCommand

  def initialize
  end
  
  def self.run(request, desmoservice_conf)
    log = ''
    origin_id = request['originid'].to_i
    destination_id = request['destinationid'].to_i
  end
  
end

class TransfertInfo
  
  attr_reader :inferior_id, :context_id
  
  def initialize(inferior_id, context_id)
    @inferior_id = inferior_id
    @context_id = context_id
  end
end