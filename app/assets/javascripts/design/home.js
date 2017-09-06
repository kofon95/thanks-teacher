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
  var postPageLink = document.getElementById("post_page_link");
  var vkButton = document.getElementById("vk_link_repost");
  var facebookButton = document.getElementById("facebook_link_repost");
  var twitterButton = document.getElementById("twitter_link_repost");
  $(document.body).click(function(e) {
      var activeItemBlockStories = $(e.target).closest(".item-block-stories");
      if(activeItemBlockStories.length === 0)
          return;

      $('.teacher-name-post').text(activeItemBlockStories.find(".teacher-block-stories").text());
      $('.school-name-post').text(activeItemBlockStories.find(".school-block-stories").text());
      $('.name-peaple-post').text(activeItemBlockStories.find(".from-whom-block-stories").text());
      $('.words-container-post').text(activeItemBlockStories.find(".text-block-stories").text());
      $('.img-post').html(activeItemBlockStories.find('.thanks-images').html());
      body.addClass("open-post");
      
      var id = activeItemBlockStories.data("postId");
      var link = `${location.href}thanks/${id}`;
      postPageLink.href = link;
      
      vkButton.innerHTML = VK.Share.button(link, {type: 'round', text: 'Опубликовать'});

      twitterButton.innerHTML = 
      `<a class="twitter-share-button"
        href="https://twitter.com/intent/tweet"
        data-url="${link}">
      Sdfsd</a>`;
      twttr.widgets.load();

      facebookButton.innerHTML =
      `<iframe
        src="https://www.facebook.com/plugins/share_button.php?href=${encodeURIComponent(link)}&layout=button_count&size=small&mobile_iframe=true&appId=843861579121790&width=137&height=20"
        width="137" height="20" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowTransparency="true"></iframe>`
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
