// document.addEventListener("turbolinks:load", function() {
$(document).ready(function() {
  $(".button-close-panel").click(function() {
    $("body").removeClass("open-submit-review-to-teacher");
  });
  $(".button-thank-you").click(function() {
    $("body").addClass("open-submit-review-to-teacher");
  });
  
  var accountImg = 1;
  setInterval(function() {
    var numbImg = $(".slider>img").length - 1; // количество изображений
    var imageSize = $(".slider>img").height(); // текущий размер изображения
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
