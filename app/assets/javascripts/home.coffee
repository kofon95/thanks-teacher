# document.addEventListener "turbolinks:load", ->
$(document).ready ->
  visitor = $("#visitor_name")
  teacher = $("#teacher_name")
  school  = $("#school_name")
  body    = $("#thank_body")

  imageNames = []

  $("#do_thank_teacher").click ->
    errors = []
    if visitor.val().length is 0
      errors.push 'введите ваше имя'
    if teacher.val().length is 0
      errors.push 'введите ваше учителя'
    if school.val().length is 0
      errors.push 'укажите учебное заведение'
    if body.val().length is 0
      errors.push 'заполните тело'

    if errors.length isnt 0
      alert("Пожалуйста, " + errors.join(", ") + ".")
      return

    data = {
      "thanks[visitor_name]": visitor.val()
      "thanks[teacher_name]": teacher.val()
      "thanks[school_name]" : school.val()
      "thanks[body]"        : body.val()
      "thanks[images]"  : imageNames
    }

    $.post("/thanks", data, ->
      visitor.val("")
      teacher.val("")
      school.val("")
      body.val("")
      alert("Ваш отзыв принят, благодарим!")
    )
    .fail((e) ->
      alert("#{e.status}: #{e.statusText}");
    )

  #######################
  searchButton = document.getElementById("do_search")
  document.getElementById("query_input").addEventListener "input", ->
    searchButton.click()

  #######################
  fileInput = $("#images_attachment")
  data = fileInput.data("formData")
  dir = fileInput.data("uploadDir") + '/'
  fileInput.withDropZone("#dropzone", {
    done: (filenames)->
      imageNames = filenames.map (f)-> dir + f
    url: fileInput.data("url")
    autoUpload: yes
    action:
      name: 'image'
      rename: (filenameWithoutExt, ext, fileIndex)-> filenameWithoutExt + ".jpg"
      params:
        preview: yes
        convertTo:
          mimeType: "image/jpeg"
          maxWidth: 1000
          maxHeight: 1000
    formData: (index, blob, filename)->
      formData = new FormData
      for i of data
        formData.set(i, data[i])
      formData.set('file', blob, filename)
      return formData
  })
