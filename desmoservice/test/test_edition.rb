require_relative '../lib/desmoservice/desmoservice'
require 'minitest/autorun'

class TestEdition < Minitest::Test
  
  def setup
  end
  
  def test_xml
    xml = ''
    edition = Desmoservice::Edition.new(xml)
    edition.link_creation(345) do |link_creation|
      link_creation.up(456, 67)
      link_creation.up('A12', 'simple/dossier')
      link_creation.family(67)
    end
    edition.link_creation('hjjh') do |link_creation|
    end
    edition.link_creation() do |link_creation|
      link_creation.up(13, 'simple/dossier')
      link_creation.text('fr', 'essai <')
      link_creation.attr('atlas:url', 'http://www.exemole.fr/')
    end
    puts xml
  end
end