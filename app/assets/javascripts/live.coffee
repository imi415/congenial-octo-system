# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

change = ->
        for player in document.getElementsByClassName 'video-js'
            video = videojs(player)
            video.hotkeys
              volumeStep: 0.1
              seekStep: 5
              enableModifiersForNumbers: false


    before_load = ->
        for player in document.getElementsByClassName 'video-js'
            video = videojs(player)
            video.dispose()


    $(document).on('turbolinks:load', change)
    $(document).on('turbolinks:before-visit', before_load)
