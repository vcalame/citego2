require_relative 'commands/transfert_liens'

class Commands
  
  def initialize
  end
  
  def self.run(request, desmoservice_conf)
    case request['command']
    when 'enregistrement-niveau1'
      return cmd_niveau1(request, desmoservice_conf)
    when 'term-change'
      return cmd_termchange(request, desmoservice_conf)
    when 'creation-niveau1'
      return cmd_creation_niveau1(request, desmoservice_conf)
    when 'transfert-liens'
      return TransfertLiensCommand.run(request, desmoservice_conf)
    when 'term-remove'
      return cmd_termremove(request, desmoservice_conf)
    when nil
      return 'commande non définie'
    else
      return 'Commande inconnue : ' + request['command']
    end
  end
  
  def self.cmd_niveau1(request, desmoservice_conf)
    log = ''
    root_id = request['id'].to_i
    categorie = request['categorie']
    edition = Desmoservice::Edition.new()
    request.params.each do |name, value|
      value.strip!
      if value.length > 0
        if name.start_with?('create_')
          request_key = name[7..-1]
          index = request_key.index('_')
          sector_id = request_key[0..index].to_i
          edition.create_ligature do |ligature_edit|
            ligature_edit.superior(root_id, sector_id)
            if request.params.has_key?('detail_' + request_key)
              other_up_key = request.params['detail_' + request_key].strip
              if other_up_key.length > 0
                ligature_edit.superior(other_up_key, 'simple/' + categorie)
              end
            end
            ligature_edit.text('fr', value)
            ligature_edit.family(664)
          end
        elsif name.start_with?('update_')
          term_id = name[7..-1].to_i
          edition.change_term(term_id) do |term_edit|
            term_edit.text('fr', value)
          end
        end
      end
    end
    Desmoservice::Post.xml(desmoservice_conf, edition.close_to_xml, log_handler: Desmoservice::LogHandler.new(log))
    return log
  end
  
  def self.cmd_termchange(request, desmoservice_conf)
    log = ''
    root_id = request['id'].to_i
    text = request['text'].strip
    if text.length > 0
      edition = Desmoservice::Edition.new()
      edition.change_term(root_id) do |term_edit|
        term_edit.text('fr', text)
      end
      Desmoservice::Post.xml(desmoservice_conf, edition.close_to_xml, log_handler: Desmoservice::LogHandler.new(log))
    else
      log = 'texte vide'
    end
    return log
  end
  
  def self.cmd_creation_niveau1(request, desmoservice_conf)
    log = ''
    superior = request['superior']
    sector = request['sector']
    prefix = request['prefix']
    text = request['text'].strip
    if text.length > 0
      edition = Desmoservice::Edition.new()
      edition.create_ligature do |ligature_edit|
        ligature_edit.superior(superior, sector)
        ligature_edit.text('fr', text)
        ligature_edit.family(34)
        ligature_edit.key_prefix(prefix)
      end
      Desmoservice::Post.xml(desmoservice_conf, edition.close_to_xml, log_handler: Desmoservice::LogHandler.new(log))
    else
      log = 'Texte vide'
    end
    return log
  end
  
  def self.cmd_termremove(request, desmoservice_conf)
    log = ''
    root_id = request['id'].to_i
    edition = Desmoservice::Edition.new()
    edition.remove_term(root_id)
    Desmoservice::Post.xml(desmoservice_conf, edition.close_to_xml, log_handler: Desmoservice::LogHandler.new(log))
    return log
  end

end