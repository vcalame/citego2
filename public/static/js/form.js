function modification(code, prefix) {
    prefix = prefix.replace( /(:|\.|\[|\])/g, "\\$1" );
    var $el = $("#descripteur_" + prefix + code);
    
    var $lib = $("#lib_"  + prefix + code + " span.Lib");
    var html = "";
    html += '<textarea cols="70" rows="3" name="update_' + code + '">'
        + $lib.html()
        + '</textarea>';
    $lib.addClass("ModifEncours");
    $el.find("div.Lien_Modification").hide();
    $el.find("div.Zone_Modification").html(html);
}

function plus(code, withDetail) {
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
    if (withDetail) {
        html += '<br>';
        html += 'Niveau 1 détaillé : ';
        html += '<input type="text" size="10" name="detail_' + id + '">';
    }
    html += '</li>';
    $("#Plus_" + code).before(html);
}