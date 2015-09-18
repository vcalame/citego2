module Desmoservice
class Edition
  
  def initialize(xml)
    @xml = xml
  end
  
  #arg peut être un entier (id) ou une chaine (localkey)
  def link_creation(down_arg=nil)
    @xml << '<lienhierarchique-creation'
    Edition.to_attribute(@xml, down_arg, 'fils')
    @xml << '>'
    yield(LinkCreation.new(@xml))
    @xml << '</lienhierarchique-creation>'
  end
  
  def self.to_attribute(xml, term_arg, suffix=nil)
    if term_arg.is_a? Integer
      xml << ' '
      if suffix.nil?
        xml << 'code' << '="' << term_arg.to_s << '"'
      else
        xml << suffix << '="' << term_arg.to_s << '"'
      end
    elsif not term_arg.nil?
      xml << ' '
      if suffix.nil?
        xml << 'iddesc' << '="' << term_arg.to_s << '"'
      else
        xml << suffix << '-iddesc="' << term_arg.to_s << '"'
      end
    end
  end
end

class LinkCreation
  
  def initialize(xml)
    @xml = xml
  end
  
  def upterm(up_arg, context_arg=nil)
    @xml << '<pere'
    Edition.to_attribute(@xml, up_arg)
    if not context_arg.nil?
      if context_arg.is_a? Integer
        @xml << ' context="' << context_arg.to_s << '"'
      else
        array = context_arg.split('/')
        @xml << ' contexte-grille="' << array[0] << '"'
        @xml << ' contexte-idctxt="' << array[1] << '"'
      end
    end
    @xml << '/>'
  end
  
end 
  
end