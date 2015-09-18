require 'rack/utils'

module Desmoservice
class Edition
  
  def initialize
    @xml = '<edition>'
  end
  
  def close_to_xml
    @xml << '</edition>'
    return @xml
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
  
  def self.family(xml, family_arg)
    xml << '<famille '
    if family_arg.is_a? Integer
        xml << 'code' << '="' << family_arg.to_s << '"'
    else
        xml << 'idctxt' << '="' << family_arg << '"'
    end
    xml << '/>'
  end
  
  def self.text(xml, lang, content)
    if content.nil?
      xml << '<lib-remove xml:lang="' << lang << '"/>'
    else
      xml << '<lib xml:lang="' << lang << '">'
      xml << Rack::Utils.escape_html(content)
      xml << '</lib>'
    end
  end
  
  def self.attr(xml, attr_key, values)
    index = attr_key.index(':')
    ns = attr_key[0,index]
    localkey = attr_key[index+1..-1]
    if values.nil?
      xml << '<attr-remove ns="' << ns << '" key="' << localkey << '"/>'
    else
      xml << '<attr ns="' << ns << '" key="' << localkey << '">'
      if values.is_a? String
        xml << '<val>' << Rack::Utils.escape_html(values) << '</val>'
      else
        values.each do |v|
          xml << '<val>' << Rack::Utils.escape_html(v) << '</val>'
        end
      end
      xml << '</attr>'
    end
  end
end

class LinkCreation
  
  def initialize(xml)
    @xml = xml
  end
  
  def up(up_arg, context_arg=nil)
    @xml << '<pere'
    Edition.to_attribute(@xml, up_arg)
    if not context_arg.nil?
      if context_arg.is_a? Integer
        @xml << ' context="' << context_arg.to_s << '"'
      else
        index = context_arg.index('/')
        @xml << ' contexte-grille="' << context_arg[0,index] << '"'
        @xml << ' contexte-idctxt="' << context_arg[index+1..-1] << '"'
      end
    end
    @xml << '/>'
  end
  
  def family(family_arg)
    Edition.family(@xml, family_arg)
  end
  
  def text(lang, content)
    Edition.text(@xml, lang, content)
  end
  
  def attr(attr_key, values)
    Edition.attr(@xml, attr_key, values)
  end
end

class TermChange
  
  def initialize(xml)
    @xml = xml
  end
  
  def family(family_arg)
    Edition.family(@xml, family_arg)
  end
  
  def text(lang, content)
    Edition.text(@xml, lang, content)
  end
  
  def attr(attr_key, values)
    Edition.attr(@xml, attr_key, values)
  end
  
end
  
end