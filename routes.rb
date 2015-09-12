require 'sinatra'

get '/' do
  "Hello World!"
end

get '/edition/' do
  %q{<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
    <html lang="fr">
    <head>
    <title>Territoires, villes et gouvernance</title>
    </head>
    <frameset cols="350,*">
    <frame name="Liste" src="menu">
    <frame name="Saisie" src="accueil">
    </frameset>}
end

get '/edition/accueil' do
  erb :edition_accueil
end

get '/edition/menu' do
  erb :edition_menu
end