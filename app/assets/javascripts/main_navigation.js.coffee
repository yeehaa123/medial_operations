$(document).ready -> 
    $('#main_nav').delay(1000).slideUp(300)
    
    $('#logo').toggle(
        ->  $('#main_nav').slideDown(300)
        ->  $('#main_nav').slideUp(300))
