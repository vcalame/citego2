class TransfertLiensCommand

  def initialize
  end
  
  def self.run(request, desmoservice_conf)
    log = ''
    origin_id = request['originid'].to_i
    destination_id = request['destinationid'].to_i
    newfamily = request['newfamily']
    edition = Desmoservice::Edition.new()
    request['transfert'].each do |v|
      transfert = v.split('/')
      context_id = transfert[0].to_i
      inferior_id = transfert[1].to_i
      edition.create_ligature(inferior_id) do |ligature_edit|
        ligature_edit.superior(destination_id, context_id)
      end
      edition.remove_ligature(inferior_id) do |ligature_edit|
        ligature_edit.superior(origin_id, context_id)
      end
      if not newfamily.nil?
        edition.change_term(inferior_id) do |term_edit|
            term_edit.family(newfamily)
        end
      end
    end
    Desmoservice::Post.xml(desmoservice_conf, edition.close_to_xml, log_handler: Desmoservice::LogHandler.new(log))
    return log
  end
  
end

class TransfertInfo
  
  attr_reader :inferior_id, :context_id
  
  def initialize(inferior_id, context_id)
    @inferior_id = inferior_id
    @context_id = context_id
  end
end