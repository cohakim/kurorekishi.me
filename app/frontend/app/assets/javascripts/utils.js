$(document).ready(function() {
  $('a[disabled=disabled]').on('click', function(e) {
    e.preventDefault();
    return false;
  });
});
