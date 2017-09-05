// document.addEventListener("turbolinks:load", function() {
$(document).ready(function() {
  var body = $("body");
  $("#button-close-panel").click(function() {
    body.removeClass("open-submit-review-to-teacher");
  });
  $(".button-thank-you").click(function() {
    body.addClass("open-submit-review-to-teacher");
  });

  // открытие и закрытие панели поста
  $("#closed-post").click(function() {
      body.removeClass("open-post");
  });
  $(document.body).click(function(e) {
      var activeItemBlockStories = $(e.target).closest(".item-block-stories");
      if(activeItemBlockStories.length === 0)
          return;

      $('.teacher-name-post').text(activeItemBlockStories.find(".teacher-block-stories").text());
      $('.school-name-post').text(activeItemBlockStories.find(".school-block-stories").text());
      $('.name-peaple-post').text(activeItemBlockStories.find(".from-whom-block-stories").text());
      $('.words-container-post').text(activeItemBlockStories.find(".text-block-stories").text());
      $('.words-container-post').text(activeItemBlockStories.find(".text-block-stories").text());
      $('.img-post').html(activeItemBlockStories.find('.thanks-images').html()); // перемещение картинок
      body.addClass("open-post");
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
