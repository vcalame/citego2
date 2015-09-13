require 'uri'

module Desmoservice
  class Conf
    
    attr_reader :service_url, :desmo_name, :lang, :dsmd_script
    
    def initialize(service_url: nil, desmo_name: nil, lang: nil, dsmd_script: nil)
      raise "Missing service_url" if service_url.nil?
      raise "Missing desmo_name" if desmo_name.nil?
      raise "Missing lang" if lang.nil?
      if service_url[-1] != "/" then
        service_url << "/"
      end
      @service_url = service_url
      @desmo_name = desmo_name
      @lang = lang
      @dsmd_script = dsmd_script
    end
    
    def build_json_url(parameters)
      map = {"desmo" => @desmo_name, "lang" => @lang}
      map.merge!(parameters)
      return @service_url + "json?" + URI.encode_www_form(map)
    end
    
    def build_dsmd_url
      dsmd_url = @service_url + "export/" + @desmo_name + "_" + @lang + ".dsmd"
      if @dsmd_script then
        dsmd_url += "?script=" + @dsmd_script
      end
      return dsmd_url
    end
    
  end

end
