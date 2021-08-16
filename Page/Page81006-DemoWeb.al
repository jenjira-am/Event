page 81006 "Demo Page"
{
    Caption = 'Demo Page';
    layout
    {
        area(Content)
        {
            usercontrol(html; HTML)
            {
                ApplicationArea = all;
                trigger ControlReady()
                begin
                    CurrPage.html.Render(createdata);
                end;
            }
        }
    }

    procedure createdata(): Text
    var
        out: Text;
    begin
        out := '<!DOCTYPE html>';
        out += '<html>';
        out += '<head>';
        out += '<meta charset="utf-8">';
        out += '<title>jQuery Signature Pad with saving As Image Using html2canvas</title>';
        out += '<script type=''text/javascript'' src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>';
        out += '<script type=''text/javascript'' src="https://cdnjs.cloudflare.com/ajax/libs/numeric/1.2.6/numeric.min.js"></script>';
        out += '<script type=''text/javascript'' src="C:/Users/Administrator/Desktop/canvas2image/canvas2image/bezier.js"></script>';
        out += '<script type=''text/javascript'' src="C:/Users/Administrator/Desktop/canvas2image/canvas2image/jquery.signaturepad.js"></script> ';
        out += '<script type=''text/javascript'' src="https://github.com/niklasvh/html2canvas/releases/download/0.4.1/html2canvas.js"></script>';
        out += '</head>';
        out += '<body>';
        out += '<div id="signatureArea" >';
        out += '<div style="height:auto;">';
        out += '<canvas id="signaturePad" width="300" height="100"></canvas>';
        out += '</div>';
        out += '</div>';
        out += '<button id="btnSaveSignature">Save Signature</button> ';
        out += '<script>';
        out += '$(document).ready(function() {';
        out += '$(''#signatureArea'').signaturePad({drawOnly:true, drawBezierCurves:true, lineTop:90});';
        out += '});';
        out += '$("#btnSaveSignature").click(function(e){';
        out += 'html2canvas([document.getElementById(''signaturePad'')], {';
        out += 'onrendered: function (canvas) {';
        out += 'var canvas_img_data = canvas.toDataURL(''image/png'');';
        out += 'var img_data = canvas_img_data.replace(/^data:image\/(png|jpg);base64,/, "");';
        out += 'console.log(img_data);';
        out += 'document.getElementById("canvasImage").src="data:image/gif;base64,"+img_data;';
        out += '}';
        out += '});';
        out += '});';
        out += '</script> ';
        out += '<p>Signature Image</p>';
        out += '<img id="canvasImage" />';
        out += '</body>';
        out += '</html>';
        exit(out);
    end;
}

/*User Contraol.al*/

controladdin HTML
{
    /*  RequestedHeight = 300;
     MinimumHeight = 300;
     MaximumHeight = 300;
     RequestedWidth = 700;
     MinimumWidth = 700;
     MaximumWidth = 700; */
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    Scripts = 'script.js';
    StartupScript = 'startup.js';

    event ControlReady();
    procedure Render(HTML: Text);
}
