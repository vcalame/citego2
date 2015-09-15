require_relative '../lib/desmoservice/desmoservice'
require 'minitest/autorun'
require 'json'

class TestTerm < Minitest::Test
  
  def setup
    @json = %q@{"iddesc":"E","code":5361,"libelles":[{"lang":"fr","lib":"Domaines de la gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/E"]}}@
    
  end
  
  def test_json
    data = JSON.parse(@json)
    term = Desmoservice::Term.new(data)
    assert_equal("Domaines de la gouvernance territoriale", term.text)
  end
  
end