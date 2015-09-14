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
  
  def text_with_id(terme)
    result = ''
    if terme.respond_to?(:iddesc)
      result = terme.iddesc
    elsif terme.respond_to?(:idctxt)
      result = terme.idctxt
    end
    if terme.text
      result += ' – ' + terme.text
    end
    Rack::Utils.escape_html(result)
  end
end

def load_edition_view(request, desmoservice_conf)
  case request['page']
  when nil
    erb(:edition_index, layout: false)
  when 'menu'
    erb(:edition_menu, locals: {desmoservice_conf: desmoservice_conf})
  when 'accueil'
    erb(:edition_accueil)
  when 'liste_niveau1'
    famille = 'niveau1@!'
    if request['grille']
      famille = request['grille'] + '@'
    end
    erb(:edition_liste_niveau1, locals: {desmoservice_conf: desmoservice_conf, famille: famille})
  end
end

get '/' do
  "Hello World!"
end

get '/edition/' do
  load_edition_view(request, desmoservice_conf)
end