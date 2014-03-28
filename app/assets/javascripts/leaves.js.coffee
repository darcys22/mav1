# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $('#calendar').fullCalendar
    editable: true,
    header:
      left: 'prev,next today',
      center: 'title',
    selectable: true
    defaultView: 'month',
    height: 500,
    slotMinutes: 30,

    eventSources: [{
      url: '/leaves',
    }],

    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5"

    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      updateEvent(event);

    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(event);

    select: (start, end, allDay) ->
      $.ajax({
        url: '/leaves/new',
        type: 'get',
        data: {start: start, end: end},
        contentType: 'json'
      });
      $('#calendar').fullCalendar('unselect')

updateEvent = (the_event) ->
  $.ajax({
    url: '/leaves/' + the_event.id,
    type: 'put',
    data: {leave: the_event},
    dataType: 'json',
  });

