
function init()
{
    var placholder = document.getElementById('controlAddIn');
    var webPage = document.createElement('iframe');
    webPage.id = 'webPage';
    webPage.height = '100%';
    webPage.width = '100%';
    placholder.appendChild(webPage);
   
}

function embedHomePage()
{
    //init()
    var myAudio = document.createElement('audio');
    if (myAudio.canPlayType('audio/mpeg')) {
        myAudio.setAttribute('src','https://interactive-examples.mdn.mozilla.net/media/cc0-audio/t-rex-roar.mp3');
      }
      
    myAudio.play();
}

function test2()
{
    init();
    var webPage = document.getElementById('webPage');
    webPage.src = 'https://developer.mozilla.org/en-US';
}