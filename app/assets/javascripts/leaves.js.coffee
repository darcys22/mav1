# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  calendar = $('#calendar').fullCalendar
    header:
      left: 'prev,next today',
      center: 'title',
      right: '',
    selectable: true
    defaultView: 'month',
    height: 500,
    slotMinutes: 30,

    eventSources: [{
      url: '/leaves',
    }],

    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5"

    eventClick: (calEvent, jsEvent, view) ->
      $.ajax({
        url: '/leaves/'+ calEvent.id + '/edit',
        type: 'get',
        data: {leave: calEvent},
        contentType: 'json',
      });

    select: (start, end, allDay) ->
      end.setHours(23,59,59,999) if allDay
      $.ajax({
        url: '/leaves/new',
        type: 'get',
        data: {start: start, end: end},
        contentType: 'json'
      });
      calendar.fullCalendar('unselect')

$(document).on('page:load', ready)
$(document).ready(ready)
