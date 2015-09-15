require_relative '../lib/desmoservice/desmoservice'
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
  
  def test_url_building
    assert_equal(
      'http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice/export/citego_fr.dsmd?script=niveau1_par_dimension',
      @conf.build_dsmd_url
    )
    assert_equal(
      'http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice/json?desmo=citego&lang=fr&fields=iddesc%2Clibelles%2Cattrs',
      @conf.build_json_url(fields: 'iddesc,libelles,attrs',selection_idctxt: nil)
    )
  end
    

end