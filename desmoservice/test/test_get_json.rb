require_relative '../lib/desmoservice/get_json'
require 'minitest/autorun'

class TestFamilles < Minitest::Test
  
  def setup
    @conf = Desmoservice::Conf.new({
      service_url:  'http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice',
      desmo_name: 'citego',
      lang: 'fr',
      dsmd_script: 'niveau1_par_dimension'
    })
    @json = %q@{"familles":{"familleArray":[{"terme":{"code":684,"libelles":[{"lang":"fr","lib":"Grilles de départ"}],"attrs":{"atlas:color":["#ffcccc"]},"active":true},"descripteurArray":[{"iddesc":"A","code":5321,"libelles":[{"lang":"fr","lib":"Éléments constitutifs des territoires, des villes et de la gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/A"]}},{"iddesc":"B","code":5331,"libelles":[{"lang":"fr","lib":"Types de territoires, de villes et de gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/B"]}},{"iddesc":"C","code":5341,"libelles":[{"lang":"fr","lib":"Dynamique des territoires, des villes, de la gouvernance"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/C"]}},{"iddesc":"D","code":5351,"libelles":[{"lang":"fr","lib":"Acteurs des territoires et de la gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/D"]}},{"iddesc":"E","code":5361,"libelles":[{"lang":"fr","lib":"Domaines de la gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/E"]}},{"iddesc":"F","code":5371,"libelles":[{"lang":"fr","lib":"Moyens de la gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/F"]}},{"iddesc":"G","code":5381,"libelles":[{"lang":"fr","lib":"Principes de gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/G"]}},{"iddesc":"H","code":5391,"libelles":[{"lang":"fr","lib":"Gouvernance territoriale et autres échelles de gouvernance"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/H"]}},{"iddesc":"I","code":5401,"libelles":[{"lang":"fr","lib":"Spécificités des territoires, villes et gouvernances territoriales dans le monde"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/I"]}}]}]}}@
  end
  
  def test_url
    assert_equal(
      'http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice/json?desmo=citego&lang=fr&type=familles&fields=iddesc%2Clibelles%2Cattrs&selection_idctxt=grille',
      Desmoservice::Familles.build_json_url(@conf, {selection_idctxt: 'grille', 'type' => 'Truc', type: 'Machin'})
    )
  end
  
  def test_json
    familles =  Desmoservice::Familles.new("")
    familles.parse_json(@json)
    assert_equal(1, familles.length)
    assert_equal(9, familles[0].descripteurs.length)
  end
  
  def test2_download
    familles = Desmoservice::Familles.download(@conf, selection_idctxt: 'grille')
    assert_equal(1, familles.length)
    assert_equal(9, familles[0].descripteurs.length)
  end
end