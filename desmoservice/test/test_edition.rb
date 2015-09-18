require_relative '../lib/desmoservice/desmoservice'
require 'minitest/autorun'

class TestEdition < Minitest::Test
  
  def setup
  end
  
  def test_xml
    xml = ''
    edition = Desmoservice::Edition.new(xml)
    edition.link_creation(345) do |link_creation|
      link_creation.upterm(456, 67)
      link_creation.upterm('A12', 'simple/dossier')
    end
    edition.link_creation('hjjh') do |link_creation|
    end
    edition.link_creation() do |link_creation|
    end
    puts xml
  end
end