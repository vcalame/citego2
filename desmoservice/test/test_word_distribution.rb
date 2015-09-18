require_relative '../lib/desmoservice/desmoservice'
require 'minitest/autorun'
require 'json'

class TestWordDistribution < Minitest::Test
  
  def setup
    @conf = Desmoservice::Conf.new({
      service_url:  'http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice',
      desmo_name: 'citego',
      lang: 'fr',
      dsmd_script: 'niveau1_par_dimension'
    })
  end
  
  def test2_json
    word_distribution = Desmoservice::WordDistribution.new()
    word_distribution.parse_json(@json)
    assert_equal(457, word_distribution.words.length)
    assert_equal(225, word_distribution.tagged_terms.length)
    tagged_text = ''
    word_distribution.tagged_terms[21].tagged_parts.each do |part|
      if part.word_id.nil?
        tagged_text += part.value
      else
        tagged_text += '<word id="' + part.word_id + '">' + part.value + '</word>'
      end
    end
    assert_equal(
      '<word id="1">organisation</word> <word id="2">sociale</word> des <word id="3">territoires</word> et des <word id="4">villes</word>',
      tagged_text
    )
  end
  
  
  def test2_download
    get_params = Desmoservice::GetParams.new()
    get_params.family_filter = 'niveau1@'
    word_distribution = Desmoservice::Get.word_distribution(@conf, get_params)
  end
end
