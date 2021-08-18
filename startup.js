/* startup.js */
init();
//HTMLContainer = document.getElementById("controlAddIn");
//Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ControlReady",[]);

function init(){

    var ControlAddIn = document.getElementById('controlAddIn');
    var BSDIV = document.createElement('div');
    BSDIV.innerText = '<div id="signatureArea" ><div style="height:auto;"><canvas id="signaturePad" width="300" height="100"></canvas></div></div>';
    
    ControlAddIn.appendChild(BSDIV);

    //var TITLE = document.createElement('title');
    //TITLE.innerText = '<title>jQuery Signature Pad with saving As Image Using html2canvas</title>';

    //var SSCript = document.createElement('script');
    //SSCript.src


    //BSDIV.innerHTML += '<div class="contenedor"></div>';

    var runtimeScript = document.createElement('script');
    runtimeScript.setAttribute('type', 'text/javascript');
    runtimeScript.setAttribute('src', 'http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js');
    document.head.appendChild(runtimeScript);

    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ControlReady",[]);
}