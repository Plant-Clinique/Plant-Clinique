$("#sort-button").on("click",function(){
  document.getElementById("myDropdown").classList.toggle("show");
});

window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

  $(window).resize(function() {

  if ($(this).width() < 1024) {

    $('.dropdown').hide();

  } else {

    $('.dropdown').show();

    }

});
