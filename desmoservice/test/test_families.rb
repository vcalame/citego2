require_relative '../lib/desmoservice/desmoservice'
require 'minitest/autorun'
require 'json'

class TestFamilies < Minitest::Test
  
  def setup
    @conf = Desmoservice::Conf.new({
      service_url:  'http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice',
      desmo_name: 'citego',
      lang: 'fr',
      dsmd_script: 'niveau1_par_dimension'
    })
    @json = %q@{"familles":{"familleArray":[{"terme":{"code":684,"libelles":[{"lang":"fr","lib":"Grilles de départ"}],"attrs":{"atlas:color":["#ffcccc"]},"active":true},"descripteurArray":[{"iddesc":"A","code":5321,"libelles":[{"lang":"fr","lib":"Éléments constitutifs des territoires, des villes et de la gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/A"]}},{"iddesc":"B","code":5331,"libelles":[{"lang":"fr","lib":"Types de territoires, de villes et de gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/B"]}},{"iddesc":"C","code":5341,"libelles":[{"lang":"fr","lib":"Dynamique des territoires, des villes, de la gouvernance"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/C"]}},{"iddesc":"D","code":5351,"libelles":[{"lang":"fr","lib":"Acteurs des territoires et de la gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/D"]}},{"iddesc":"E","code":5361,"libelles":[{"lang":"fr","lib":"Domaines de la gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/E"]}},{"iddesc":"F","code":5371,"libelles":[{"lang":"fr","lib":"Moyens de la gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/F"]}},{"iddesc":"G","code":5381,"libelles":[{"lang":"fr","lib":"Principes de gouvernance territoriale"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/G"]}},{"iddesc":"H","code":5391,"libelles":[{"lang":"fr","lib":"Gouvernance territoriale et autres échelles de gouvernance"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/H"]}},{"iddesc":"I","code":5401,"libelles":[{"lang":"fr","lib":"Spécificités des territoires, villes et gouvernances territoriales dans le monde"}],"attrs":{"atlas:ventilationnaturelle":["ventilation:contexte:complete/I"]}}]}]}}@
  end
  
  def test_json
    families =  Desmoservice::Families.new("")
    families.parse_json(@json)
    assert_equal(1, families.length)
    assert_equal(9, families[0].members.length)
    assert_equal("Grilles de départ", families[0].text)
    assert_equal("Éléments constitutifs des territoires, des villes et de la gouvernance territoriale", families[0].members[0].text)
  end
  
  def test_download
    get_params = Desmoservice::GetParams.new()
    get_params.family_filter = 'grille'
    families = Desmoservice::Get.families(@conf, get_params)
    puts families.url
    assert_equal(1, families.length)
    assert_equal(9, families[0].members.length)
  end
end

