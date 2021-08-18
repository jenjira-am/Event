
function init(ItemNo, Desc)
{
    var placholder = document.getElementById('controlAddIn');
    var webPage = document.createElement('iframe');
    webPage.id = 'webPage';
    webPage.height = '100%';
    webPage.width = '100%';
    placholder.appendChild(webPage);

    var div1 = document.createElement('div1');
    var div2 = document.createElement('div2');

    
    placholder.append(div1);
    placholder.append(div2);
    
}

function embedHomePage()
{
    //init()
    var myAudio = document.createElement('audio');
    if (myAudio.canPlayType('audio/mpeg')) {
        myAudio.setAttribute('src','https://github.com/jenjira-am/Event/releases/download/1/mixkit-tile-game-reveal-960.wav');
      }
      
    myAudio.play();
}

function test2()
{
    //init();
    var webPage = document.getElementById('webPage');
    webPage.src = 'https://developer.mozilla.org/en-US';
}