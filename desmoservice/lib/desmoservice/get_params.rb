module Desmoservice
class GetParams

  attr_accessor :with_keys, :with_attrs,
      :family_filter,
      :ventilation_root_id, :ventilation_root_uri, :ventilation_name,
      :ignore_empty_sectors
      
  
  def initialize()
    @with_keys = true
    @with_attrs = false
    @ventilation_root_id = nil
    @ventilation_root_uri = nil
    @ignore_empty_sectors = nil
    @ventilation_name = 'ventilation:naturelle'
  end
  
  def to_h(type)
    result = Hash.new
    result['type'] = type
    fields = 'libelles,famille-color'
    fields += ',idctxt,iddesc,grille-name' if @with_keys
    fields += ',attrs' if @with_attrs
    result['fields'] = fields
    if not @family_filter.nil?
      if type == 'ventilation'
        options['conf:limitation.familles.idctxtarray'] = @family_filter
      else
        result['selection_idctxt'] = @family_filter
      end
    end
    if not @ignore_empty_sectors.nil?
      if @ignore_empty_sectors
        result['conf:ignore.empty.secteur'] = 'true'
      else
        result['conf:ignore.empty.secteur'] = 'false'
      end
    end
    if type == 'ventilation'
      if not @ventilation_root_id.nil?
        result['root_code'] = @ventilation_root_id
      elsif not @ventilation_root_uri.nil?
        result['root_uri'] = @ventilation_root_uri
      end
      if not @ventilation_name.nil?
        result['name'] =  @ventilation_name
      end
    end
    return result
  end
  
  def ventilation_name_uri=(uri)
    @ventilation_name = 'ventilation:' + uri
  end
  
  def ventilation_name_context=(localkey)
    index = localkey.index('/')
    if index.nil?
      @ventilation_name = 'ventilation:grille:' + localkey
    else
      @ventilation_name = 'ventilation:contexte:' + localkey
    end
  end
  
end
end