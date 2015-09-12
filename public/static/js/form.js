function modification(code, prefix) {
    prefix = prefix.replace( /(:|\.|\[|\])/g, "\\$1" );
    var el = $("#descripteur_" + prefix + code);
    
    var lib = $("#lib_"  + prefix + code + " span.Lib");
    var html = "";
    html += '<textarea cols="70" rows="3" name="update_' + code + '">'
        + lib.html()
        + '</textarea>';
    el.html(html);
}

function plus(code) {
    var numero = 2;
    while(true) {
        if ($("*[name='create_" + code + "_" + numero + "']").length == 0) {
            break;
        } else {
            numero++;
        }
    }
    var id = code + '_' + numero;
    var html = '<li class="Descripteur">';
    html += '<textarea cols="70" rows="3" name="create_'
    + id + '"></textarea>';
    html += '<br>';
    html += 'Niveau 1 détaillé : ';
    html += '<input type="text" size="10" name="detail_' + id + '">';
    html += '</li>';
    $("#Plus_" + code).before(html);
}