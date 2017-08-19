document.addEventListener "turbolinks:load", ->
  visitor = $("#visitor_name")
  teacher = $("#teacher_name")
  school  = $("#school_name")
  body    = $("#thank_body")

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
