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
  
  def span_color(term, with_links: false, with_removelink: false)
    result = colored_key(term)
    if term.text
      result += ' – <span class="Lib">' + Rack::Utils.escape_html(term.text) + '</span>'
    end
    if with_links
      result += term_links(term, with_removelink: with_removelink)
    end
    return result
  end
  
  def term_links(term, with_removelink: false)
    result = ' <small>['
    result += '<a data-link-type="modal" href="?page=modal_state&amp;id=' + term.id.to_s + '">info</a>'
    result += ' – '
    result += '<a target="_blank" href="../static/desmoclient/desmoclient.html#' + term.id.to_s + '|ventilation:naturelle">desmo</a>'
    if term.parent_localkey == 'niveau2'
        result += ' – '
        result += '<a href="?page=form_niveau2&amp;id=' + term.id.to_s + '">liens</a>'
    end
    if with_removelink
      result += ' – '
      result += '<a data-link-type="modal" href="?page=modal_remove&amp;id=' + term.id.to_s + '">supprimer</a>'
    end
    result += ']</small>'
    return result
  end
  
  def div_background(term)
    result = '<div class="public-DescripteurBloc">'
    result += '<span style="background-color:' + term.color + '">'
    result += text_with_key(term)
    result += '</span>'
    result += '</div>'
    return result
  end
  
end