class Commands
  
  def initialize
  end
  
  def self.run(request, desmoservice_conf)
    case request['command']
    when 'enregistrement-niveau1'
      cmd_niveau1(request, desmoservice_conf)
    end
  end
  
  def self.cmd_niveau1(request, desmoservice_conf)
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
          edition.link_creation do |link_creation|
            link_creation.up(root_id, sector_id)
            if request.params.has_key?('detail_' + request_key)
              other_up_key = request.params['detail_' + request_key].strip
              if other_up_key.length > 0
                link_creation.up(other_up_key, 'simple/' + categorie)
              end
            end
            link_creation.text('fr', value)
            link_creation.family(664)
          end
        elsif name.start_with?('update_')
          term_id = name[7..-1].to_i
          edition.term_change(term_id) do |term_change|
            term_change.text('fr', value)
          end
        end
      end
    end
    log = ''
    Desmoservice::Post.xml(desmoservice_conf, edition.close_to_xml, Desmoservice::LogHandler.new(log))
    puts log
  end
  
end