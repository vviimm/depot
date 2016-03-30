window.Uploader =
  init: ->
    console.log 'i am initialized'

    $('#photo_image').fileupload
      url: '/photos'
      dataType: 'json'
      add: (e, data)->

        if data.files and data.files[0]
          reader = new FileReader

          reader.onload = (e) ->
            src = e.target.result
            $( "<img id='target' class='thumbnail' src='#' alt='your image' />" ).insertAfter("#photo_image")
            $('#target').attr 'src', src
            return

          reader.readAsDataURL data.files[0]

        data.submit()
      done: ->
        console.log arguments
      fail: ->
        console.log 'fail'
