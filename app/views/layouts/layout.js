$(window).resize(function() {
    if ($(this).width() < 1300) {
      $('.uncollapsed').hide(); /* hide uncollapsed navbar version */ 
      $('.collapsed-nav').show(); /* show collapsed */
    } else {
      $('.collapsed-nav').hide(); /* hide collapsed */ 
      $('.uncollapsed').show(); /* show uncollapsed */
    }
  });
  
  if ($(this).width() < 1300) {
    $('.uncollapsed').hide(); /* hide uncollapsed navbar version */ 
    $('.collapsed-nav').show(); /* show collapsed */
  }
  else  {
    $('.collapsed-nav').hide(); /* hide collapsed */ 
    $('.uncollapsed').show(); /* show uncollapsed */
  }
 
  console.log('welcome to the plant-clinique log')