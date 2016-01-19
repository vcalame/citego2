require 'sinatra'
require 'desmoservice'
#require_relative '../../gems/desmoservice/lib/desmoservice'
require_relative 'helpers'
require_relative 'commands'

desmoservice_conf = Desmoservice::Conf.new({
  service_url:  'http://bases.fichotheque.net:8080/citego/travail/ext/fr-exemole-desmoservice',
  #service_url:  'http://localhost:8080/travail/ext/fr-exemole-desmoservice',
  desmo_name: 'citego',
  lang: 'fr',
  dsmd_script: 'niveau1_par_dimension'
})

def load_public_view(request, desmoservice_conf)
  locals = {desmoservice_conf: desmoservice_conf}
  case request['page']
  when nil
    target = ""
    if request['target']
      target = request['target']
    end
    locals[:target] = target
    erb(:public_index, locals: locals)
  when 'niveau0'
    target = ""
    if request['target']
      target = request['target']
    end
    locals[:target] = target
    locals[:family_filter] = request['family'] + '@'
    erb(:public_niveau0, locals: locals)
  when 'niveau1'
    locals[:id] = request['id']
    erb(:public_niveau1, locals: locals)
  when 'recherche'
    locals[:query] = request['q']
    erb(:public_recherche, locals: locals)
  when 'modal'
    locals[:id] = request['id']
    erb(:public_modal, locals: locals, layout: false)
  end
end


def load_edition_view(request, desmoservice_conf, log=nil)
  locals = {desmoservice_conf: desmoservice_conf, log: log}
  case request['page']
  when nil
    erb(:edition_index, layout: false)
  when 'menu'
    erb(:edition_menu, locals: locals)
  when 'accueil'
    erb(:edition_accueil)
  when 'liste_niveau1'
    locals[:id] = request['lignematrice']
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
    when 'N3'
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
  when 'selection_transfert'
    erb(:edition_selection_transfert, locals: locals)
  when 'form_transfert'
    locals[:originkey] = request['originkey']
    locals[:destinationkey] = request['destinationkey']
    erb(:edition_form_transfert, locals: locals)
  when 'modal_state'
    locals[:id] = request['id']
    erb(:modal_state, locals: locals, layout: false)
  when 'descripteurs'
    erb(:edition_descripteurs, locals: locals)
  when 'modal_remove'
    locals[:id] = request['id']
    erb(:modal_remove, locals: locals, layout: false)
  when 'recherche'
    locals[:query] = request['q']
    erb(:edition_recherche, locals: locals)
  end
end

get '/' do
  erb(:index, layout: false)
end

get '/blank' do

end

get '/edition/' do
  load_edition_view(request, desmoservice_conf)
end

get '/public/' do
  load_public_view(request, desmoservice_conf)
end

post '/edition/' do
  log = Commands.run(request, desmoservice_conf)
  load_edition_view(request, desmoservice_conf, log)
end