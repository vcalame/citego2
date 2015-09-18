require 'sinatra'
require_relative 'desmoservice/lib/desmoservice/desmoservice'
require_relative 'helpers'
require_relative 'commands'

desmoservice_conf = Desmoservice::Conf.new({
  service_url:  'http://bases.fichotheque.net:8080/exemole/ext/fr-exemole-desmoservice',
  #service_url:  'http://localhost:8080/travail/ext/fr-exemole-desmoservice',
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
    family_filter = 'niveau1@!'
    if request['grille']
      family_filter = request['grille'] + '@'
    end
    locals[:family_filter] = family_filter
    erb(:edition_liste_niveau1, locals: locals)
  when 'dossiers'
    family_filter = 'niveau1@!'
    if request['grille']
      family_filter = request['grille'] + '@'
    end
    locals[:family_filter] = family_filter
    erb(:edition_dossiers, locals: locals)
  when 'listepermutee'
    niveau = request['niveau']
    case niveau
    when 'N1'
    when 'N2'
    when 'tous'
    else
      return 'Niveau inconnu'
    end
    locals[:niveau] = niveau
    erb(:edition_listepermutee, locals: locals)
  when 'form_niveau1'
    locals[:id] = request['id']
    erb(:edition_form_niveau1, locals: locals)
  when 'form_change'
    locals[:id] = request['id']
    erb(:edition_form_change, locals: locals)
  end
end

get '/' do
  "Hello World!"
end

get '/edition/' do
  load_edition_view(request, desmoservice_conf)
end

post '/edition/' do
  Commands.run(request, desmoservice_conf)
  load_edition_view(request, desmoservice_conf)
end