$(document).ready -> 
    # $('#main_nav').slideUp(1000)    
    $('#logo').toggle(
        ->  $('#main_nav').slideDown(300)
        ->  $('#main_nav').slideUp(300))