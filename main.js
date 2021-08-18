const controlAddIn = $('#controlAddIn');

$("#controlAddIn").html(`  
    <!DOCTYPE html>
    <html>
        <head>
            <meta charset="utf-8">
            <title>jQuery Signature Pad with saving As Image Using html2canvas</title>
            <script type='text/javascript' src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
            <script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/numeric/1.2.6/numeric.min.js"></script>
            <script type='text/javascript' src="https://github.com/jenjira-am/Event/releases/download/1/bezier.js"></script>
            <script type='text/javascript' src="https://github.com/jenjira-am/Event/releases/download/1/jquery.signaturepad.js"></script>
            <script type='text/javascript' src="https://github.com/niklasvh/html2canvas/releases/download/0.4.1/html2canvas.js"></script>
        </head>
        <body>       
            <div id="signatureArea" >
                <div style="height:auto;">
                    <canvas id="signaturePad" width="300" height="100"></canvas>
                </div>
            </div>        
            <button id="btnSaveSignature">Save Signature</button>        
            
            <script>
                $(document).ready(function() {
                    $('#signatureArea').signaturePad({drawOnly:true, drawBezierCurves:true, lineTop:90});
                });
                
                $("#btnSaveSignature").click(function(e){
                    html2canvas([document.getElementById('signaturePad')], {
                        onrendered: function (canvas) {
                            var canvas_img_data = canvas.toDataURL('image/png');
                            var img_data = canvas_img_data.replace(/^data:image\/(png|jpg);base64,/, "");
                            console.log(img_data);
                            document.getElementById("canvasImage").src="data:image/gif;base64,"+img_data;
                        }
                    });
                });
            </script> 
            <p>Signature Image</p>
            <img id="canvasImage" />
        </body>
    </html>
` );
