var DSM_options = {
serviceUrl: "http://bases.basedefiches.net:8080/exemole/ext/fr-exemole-desmoservice/",
desmoName: "citego",
homeVentilationName: "ventilation:naturelle",
homeRootUri: "descripteur:titre",
famillesActivation: 0,
famillesSelection: "niveau1@!"
};

var DSM_custom = new Object();

DSM_custom.newLibelleSpan = function(terme, catalogClass) {
  if (terme.code == 773) {
    return {state: "null"};
  }
  var custom_type = "";
  if (catalogClass == "dsm-terme-Boite_Bordure") {
  	catalogClass = catalogClass + " dsm-link-No";
  	custom_type = "classes";
  }
  if (!terme.libelles) {
    return {state: "default"};
  }
  var text = "";
  var lang = "";
  if ((terme.iddesc) && (terme.familleIdctxt)) {
    if ((terme.familleIdctxt == "grille") || (terme.familleIdctxt.length == 2)) {
      custom_type = "html";
      text = terme.iddesc + " – " + terme.libelles[0]["lib"];
      lang = terme.libelles[0]["lang"];
    } else if (terme.familleIdctxt == "dossier") {
    	catalogClass = catalogClass + " dsm-link-Url";
    	custom_type = "classes";
    }
  } else if (terme.idctxt) {
  	if (terme.idctxt == "dossier") {
  	  catalogClass = catalogClass + " dossiers";
  	} else {
  	  custom_type = "html";
      text = terme.idctxt + " – " + terme.libelles[0]["lib"];
      lang = terme.libelles[0]["lang"];
  	}
  }
  if (custom_type == "html") {
    var html = '<span class="' + catalogClass + '" style="background-color: ' + terme.familleColor + '" lang="' + lang + '">' + text + '</span>';
    return {state: "html", html: html};
  } else if (custom_type == "classes") {
	return {state: "classes", classes: catalogClass};
  } else {
  	return {state: "default"};
  }
}