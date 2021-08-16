/* startup.js */
//init();
HTMLContainer = document.getElementById("controlAddIn");
Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("ControlReady",[]);

function init(){

    var div = document.getElementById('controlAddIn');
    div.innerHTML += '<div class="contenedor"></div>';

    var runtimeScript = document.createElement('script');
    runtimeScript.src = appUrl;
    document.head.appendChild(runtimeScript);
}