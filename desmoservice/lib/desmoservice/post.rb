require 'net/http'

module Desmoservice
class Post
  
  def initialize
  end
  
  def self.xml(desmoservice_conf, xml, http=nil)
    puts xml
    uri = desmoservice_conf.build_edition_uri
    if http.nil?
      response = Net::HTTP.post_form(uri, 'desmo' => desmoservice_conf.desmo_name, 'xml' => xml)
    else
      request = Net::HTTP::Post.new(uri)
      request.set_form_data('desmo' => desmoservice_conf.desmo_name, 'xml' => xml)
      http.request(request)
    end
  end

end

end