// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function select_all_for_email()
{
    var field = document.getElementsByTagName('input');
	for (i = 0; i < field.length; i++) {
	  field[i].checked = true ;
	}
	return false;
}