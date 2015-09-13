require_relative '../lib/desmoservice/conf'
require 'minitest/autorun'

class TestConf < Minitest::Test

  def setup
    @conf = Desmoservice::Conf.new({
      service_url:  'http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice',
      desmo_name: 'citego',
      lang: 'fr',
      dsmd_script: 'niveau1_par_dimension'
    })
  end
  
  def test_build
    assert_equal('http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice/export/citego_fr.dsmd?script=niveau1_par_dimension',
      @conf.build_dsmd_url)
  end
    

end