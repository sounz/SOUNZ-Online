//nothing here yet


function update_from_popup(element_id,controllerName, actionName, object_id)
{
 
   // non modal w = window.opener.document.getElementById(element_id);

// modal
w = window.parent.document.getElementById(element_id);
    url = "/"+controllerName+"/"+actionName+"/"+object_id
    
 // DEBUG   alert("W is " + w)
 // DEBUG   alert("url is " + url)
 
   // setting asynch to false is necessary, as the window close stops ajax from happening otherwise
  new Ajax.Updater(w, url, {asynchronous:false, evalScripts:true, onComplete:function(request){new Effect.Highlight( w)}});

  // Remove the popup
  // non modal  window.close();
window.parent.hidePopWin()
}


//these functions are called from clicking on the facets
function expand_collapse(ind) {
  s=document.getElementById(ind);
  /* FIXME: jquery this please */
  if (s.classList[1] == 'closed')  {
    s.classList.remove('closed');
    s.classList.add('open');
  }
  else {
    s.classList.remove('open');
    s.classList.add('closed');
  }
/*
 if (s.style.display == 'none') {
   s.style.display='block';
 }
 else if (s.style.display == 'block') {
   s.style.display = 'none';
 }
*/
}
function hide_display_arrow(ind) {
 s=document.getElementById(ind);
 if (s.style.display == 'none') {
   s.style.display='inline';
 }
 else if (s.style.display == 'inline') {
   s.style.display = 'none';
 }
}
function expand(ind) {
 s=document.getElementById(ind);
 if (!s) return false;
 s.style.display='block';
}
function collapse(ind) {
 s=document.getElementById(ind);
 if (!s) return false;
 s.style.display='none';
}





    
