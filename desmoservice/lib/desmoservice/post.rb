require 'net/http'

module Desmoservice
class Post
  
  def initialize
  end
  
  def self.xml(desmoservice_conf, xml, log_handler=nil, http=nil)
    uri = desmoservice_conf.build_edition_uri
    if http.nil?
      response = Net::HTTP.post_form(uri, 'desmo' => desmoservice_conf.desmo_name, 'xml' => xml)
      response_body = response.body
    else
      request = Net::HTTP::Post.new(uri)
      request.set_form_data('desmo' => desmoservice_conf.desmo_name, 'xml' => xml)
      response =http.request(request)
      response_body = response.body
    end
    if not log_handler.nil?
      json = JSON.parse(response_body)
      if json.has_key?('error')
        error = json['error']
        message= "[[RequestParams]]\n      [" + error['key']
        if error.has_key?('parameter')
          message += ' / ' + error['parameter']
        end
        message += ']'
        if error.has_key?('value')
          message += ' ' + error['value']
        end
        log_handler.add_log_message(message)
      end
      if json.has_key?('log')
        log_handler.add_log_message(json['log'])
      end
    end
  end

end

end