require 'sinatra'
require_relative 'desmoservice/lib/desmoservice/conf'
require_relative 'desmoservice/lib/desmoservice/get_json'
require_relative 'helpers'

desmoservice_conf = Desmoservice::Conf.new({
  service_url:  'http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice',
  desmo_name: 'citego',
  lang: 'fr',
  dsmd_script: 'niveau1_par_dimension'
})



def load_edition_view(request, desmoservice_conf)
  locals = {desmoservice_conf: desmoservice_conf}
  case request['page']
  when nil
    erb(:edition_index, layout: false)
  when 'menu'
    erb(:edition_menu, locals: locals)
  when 'accueil'
    erb(:edition_accueil)
  when 'liste_niveau1'
    selection_idctxt = 'niveau1@!'
    if request['grille']
      selection_idctxt = request['grille'] + '@'
    end
    locals[:selection_idctxt] = selection_idctxt
    erb(:edition_liste_niveau1, locals: locals)
  when 'dossiers'
    selection_idctxt = 'niveau1@!'
    if request['grille']
      selection_idctxt = request['grille'] + '@'
    end
    locals[:selection_idctxt] = selection_idctxt
    erb(:edition_dossiers, locals: locals)
  end
end

get '/' do
  "Hello World!"
end

get '/edition/' do
  load_edition_view(request, desmoservice_conf)
end