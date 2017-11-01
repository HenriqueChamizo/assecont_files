function controlvisibility(mycontrol) {
    if (mycontrol.style.visibility != 'visible') {
        controlshow(mycontrol)
    }
    else {
        controlhidden(mycontrol);
    }
}

function controlshow(mycontrol) {
    mycontrol.style.visibility = 'visible';
    mycontrol.style.position = 'relative';
}

function controlhidden(mycontrol) {
    mycontrol.style.visibility = 'hidden';
    mycontrol.style.position = 'absolute';
}