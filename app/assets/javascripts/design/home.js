// document.addEventListener("turbolinks:load", function() {
$(document).ready(function() {
  var body = $("body");
  $(".button-close-panel").click(function() {
    body.removeClass("open-submit-review-to-teacher");
  });
  $(".button-thank-you").click(function() {
    body.addClass("open-submit-review-to-teacher");
  });
  
  var accountImg = 0;
  var slider = $(".slider");
  var imgs = slider.children("img");
  var numbImg = imgs.length - 1; // количество изображений
  setInterval(function() {
    var imageSize = imgs.height() * accountImg; // текущий размер изображения
    accountImg = numbImg === accountImg ? 0 : accountImg + 1;
    slider.css("top", -imageSize + "px");
  }, 10000);
});
