helpers do
  def h(text)
    return Rack::Utils.escape_html(text)
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
    return Rack::Utils.escape_html(result)
  end
  
  def span_color(descripteur)
    result = ''
    if descripteur.color
      result += '<span style="background-color:' + descripteur.color + '">' + descripteur.iddesc + '</span>'
    else
      result += descripteur.iddesc
    end
    if descripteur.text
      result += ' – ' + Rack::Utils.escape_html(descripteur.text)
    end
    return result
  end
end