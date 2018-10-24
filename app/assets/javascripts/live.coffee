# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

    change = -> 
        dp = new DPlayer({
            container: document.getElementById 'dplayer',
            screenshot: true
            video: {
                url: document.getElementById 'local-player',
                type: 'hls'
            }
        })


    before_load = ->
        dp = new DPlayer({
            container: document.getElementById 'dplayer',
            screenshot: true
            video: {
                url: document.getElementById 'local-player',
                type: 'hls'
            }
        })

    $(document).on('turbolinks:load', change)
    $(document).on('turbolinks:before-visit', before_load)
