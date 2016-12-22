#= require ./direction
#= require ./position

{Direction, Position} = TaoPopover

class TaoPopover.Component extends TaoComponent

  @tag: 'tao-popover'

  @id: 0

  @property 'active', 'targetSelector', 'targetTraversal', 'boundarySelector', 'direction', 'offset', 'arrowAlign', 'arrowVerticalAlign', observe: true

  @property 'autohide', default: true

  constructor: ->
    _instance = super
    @id ++
    _instance

  _init: ->
    @target = if @targetTraversal
      $(@)[@targetTraversal]?(@targetSelector)
    else
      $ @targetSelector

    @_initAutoHide() if @active && @autohide
    @refresh()

  attributeChangedCallback: ->
    super
    @refresh()

  _activeChanged: ->
    if @autohide
      if @active
        @_enableAutoHide()
      else
        @_disableAutoHide()

  _enableAutoHide: ->
    $(document).on "mousedown.tao-popover-#{@id}", (e) =>
      return unless @active
      target = $ e.target
      return if target.is(@target) or $(@).has(target).length or target.is(@)
      @active = false

  _disableAutoHide: ->
    $(document).off "mousedown.tao-popover-#{@id}"

  refresh: ->
    direction = new Direction
      popover: @
      target: @target
      boundarySelector: @boundarySelector

    @direction ||= direction.toString()

    @position = new Position
      direction: direction
      arrowAlign: @arrowAlign
      arrowVerticalAlign: @arrowVerticalAlign
      offset: @offset

    $(@).css
      top: @position.top
      left: @position.left

  _destroy: ->
    @_disableAutoHide()

TaoComponent.register TaoPopover.Component
