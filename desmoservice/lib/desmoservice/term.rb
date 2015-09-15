module Desmoservice

class Term
  attr_reader :id, :key, :text, :color, :attrs
  
  def initialize(data)
    @id = data['code']
    @key = if data.has_key?('iddesc')
             data['iddesc']
           elsif data.has_key?('idctxt')
             data['idctxt']
           else
             nil
           end
    @text = nil
    if data.has_key?('libelles')
      if data['libelles'].length > 0
        @text = data['libelles'][0]['lib']
      end
    end
    @color = nil
    if data.has_key?('familleColor')
      @color = data['familleColor']
    end
    @attrs = nil
    if data.has_key?('attrs')
      @attrs = data['attrs']
    end
  end
  
  def key?
    return !@key.nil?
  end

  def text?
    return !@text.nil?
  end
  
  def color?
    return !@color.nil?
  end
  
  def has_attr?
    if @attrs.nil?
      return false
    else
      return @attrs.has_key?(key)
    end
  end
  
  def [](key)
    if @attrs.nil?
      return nil
    elsif !@attrs.has_key?(key)
      return nil
    else
      return @attrs[key]
    end
  end
end

end
