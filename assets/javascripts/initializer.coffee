$ ->



  $('.button').on 'click', ->

    rel = $(@).attr('rel')

    $('.modal-overlay').show()
    $(".modal-form.#{rel}").css('top', '-1000px')

    $('.modal-overlay').unbind()
    $('.modal-overlay').on 'click', ->
      hide_form()

    $('.modal-overlay').animate({'opacity' : '0.6'}, 200, ->
      $(".modal-form.#{rel}").show()
      $(".modal-form.#{rel}").animate({'top': '50%'}, 200)
    )

  $('#hide-thank-you').on 'click', ->
    hide_thank_you()



  $('.send-form').on 'click', ->

    username = $(@).parent().find('input[name=name]')
    phone = $(@).parent().find('input[name=phone]')

    shake_fields = []

    if username.val() < 2
      shake_fields.push username

    if phone.val() < 10
      shake_fields.push phone

    if shake_fields.length > 0
      shake_field(field) for field in shake_fields
      return false

    $.post(
      '/orders.json',
      {
        'order[name]': username.val(),
        'order[phone]': phone.val()
      }
    )


    $('.modal-form').animate({'top': '-1000px'}, 300, ->
      show_thank_you()
    )

    reach_goal 'new_order'




window.hide_form = ->
  $('.modal-form').animate {'top': '-2000px'}, 500, ->
    $('.modal-form').hide()
    $('.modal-overlay').animate {'opacity': '0'}, 300, ->
      $('.modal-overlay').hide()


window.show_thank_you = ->

  $('.modal-overlay').unbind()
  $('.modal-overlay').on 'click', ->
    hide_thank_you()

  $('.modal-thank-you').css('right', '-500px')
  $('.modal-thank-you').show()
  $('.modal-thank-you').animate({'right': '50%'}, 500, ->
    $('input').val('')
  )

window.hide_thank_you = ->
  $('.modal-thank-you').animate {'top': '-2000px'}, 500, ->
    $('.modal-thank-you').hide()
    $('.modal-overlay').animate {'opacity': '0'}, 300, ->
      $('.modal-overlay').hide()


window.shake_field = (field) ->
  shake(field, i) for i in [1..10]


window.shake = (field, i) ->

  if i%2
    field.animate({height: '-=15'}, 100)
  else
    field.animate({height: '+=15'}, 100)

window.reach_goal = (goal) ->
  26000148.reachGoal(goal)



