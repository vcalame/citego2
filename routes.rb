require 'sinatra'
require_relative 'desmoservice/lib/desmoservice/conf'
require_relative 'desmoservice/lib/desmoservice/get_json'

desmoservice_conf = Desmoservice::Conf.new({
  service_url:  'http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice',
  desmo_name: 'citego',
  lang: 'fr',
  dsmd_script: 'niveau1_par_dimension'
})

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
  
  def text_with_iddesc(descripteur)
    result = descripteur.iddesc
    if descripteur.text
      result += ' – ' + descripteur.text
    end
    Rack::Utils.escape_html(result)
  end
end

def load_edition_view(request, desmoservice_conf)
  case request['page']
  when nil
    erb(:edition_index, layout: false)
  when "menu"
    erb(:edition_menu, locals: {desmoservice_conf: desmoservice_conf})
  when "accueil"
    erb(:edition_accueil)
  end
end

get '/' do
  "Hello World!"
end

get '/edition/' do
  load_edition_view(request, desmoservice_conf)
end