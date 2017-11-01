function openProcess() {
         GetRadWindow().close();
         top.location.href = top.location.href;
     }

function GetRadWindow() {
    var oWindow = null;
    if (window.radWindow)
        oWindow = window.radWindow;
    else if (window.frameElement.radWindow)
        oWindow = window.frameElement.radWindow;
    return oWindow;
}