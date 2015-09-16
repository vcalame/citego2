helpers do
  def h(text)
    return Rack::Utils.escape_html(text)
  end
  
  def text_with_key(term)
    result = ''
    if term.localkey?
      result += term.localkey
    end
    if term.text?
      result += ' – ' + term.text
    end
    return Rack::Utils.escape_html(result)
  end
  
  def colored_key(term)
    result = ''
    if term.color?
      result += '<span style="background-color:' + term.color + '">' + term.localkey + '</span>'
    else
      result += term.localkey
    end
    return result
  end
  
  def span_color(term)
    result = colored_key(term)
    if term.text
      result += ' – <span class="Lib">' + Rack::Utils.escape_html(term.text) + '</span>'
    end
    return result
  end
end