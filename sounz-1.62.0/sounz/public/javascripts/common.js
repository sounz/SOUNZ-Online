function toggleElement(element_id)
{
    var element = document.getElementById(element_id);
    if (element) {
        if (element.style.display == "") {
            element.style.display = "block";
        } else {
            element.style.display = "";
        }
    }
}

function getWindowHeight()
{
    var windowHeight=0;
    if (typeof(window.innerHeight)=='number') {
        windowHeight=window.innerHeight;
    } else {
        if (document.documentElement && document.documentElement.clientHeight) {
            windowHeight = document.documentElement.clientHeight;
        } else {
            if (document.body&&document.body.clientHeight) {
                windowHeight=document.body.clientHeight;
            }
        }
    }

    return windowHeight;
}

function getScrollHeight()
{
    var scrollHeight=0;
    if (typeof(window.scrollHeight)=='number') {
        scrollHeight=window.scrollHeight;
    } else {
        if (document.documentElement && document.documentElement.scrollHeight) {
            scrollHeight = document.documentElement.scrollHeight;
        } else {
            if (document.body&&document.body.scrollHeight) {
                scrollHeight=document.body.scrollHeight;
            }
        }
    }

    return scrollHeight;
}