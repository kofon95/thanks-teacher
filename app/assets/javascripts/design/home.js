// document.addEventListener("turbolinks:load", function() {
$(document).ready(function() {
  $(".button-close-panel").click(function() {
    $(".submit-review-to-teacher").removeClass("open-submit-review-to-teacher");
  });
  $(".button-thank-you").click(function() {
    $(".submit-review-to-teacher").addClass("open-submit-review-to-teacher");
  });
  
  var accountImg = 1;
  setInterval(function() {
    var numbImg = $(".slider>img").length;
    var imageSize = $(".slider>img").height();
    imageSize = imageSize * accountImg;
    if(numbImg == accountImg) {
      accountImg = 1;
      imageSize = 0;
    }
    else {
      accountImg++;
    }
    $(".slider").css("top", "-" + imageSize);
  }, 10000);
});
