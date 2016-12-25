#= require ./direction
#= require ./position

{Direction, Position} = TaoPopover

class TaoPopover.Component extends TaoComponent

  @tag: 'tao-popover'

  @count: 0

  @property 'active', 'targetSelector', 'targetTraversal', 'boundarySelector', 'direction', 'arrowAlign', 'arrowVerticalAlign', observe: true

  @property 'offset', observe: true, default: 5

  @property 'autoHide', default: true

  _init: ->
    @id ||= "tao-popover-#{++@constructor.count}"
    @_render

  _render: ->
    $(@).wrapInner '<div class="tao-popover-content">'
      .append '''
        <div class="tao-popover-arrow">
          <i class="arrow arrow-shadow"></i>
          <i class="arrow arrow-border"></i>
          <i class="arrow arrow-basic"></i>
        </div>
      '''

  _connect: ->
    @_render()
    @_autoHideChanged()
    @refresh()

  attributeChangedCallback: ->
    return if @_refreshing
    super
    @refresh()

  _activeChanged: ->
    if @autoHide
      if @active
        @_enableAutoHide()
      else
        @_disableAutoHide()

  _autoHideChanged: ->
    @_disableAutoHide()
    @_enableAutoHide() if @autoHide && @active

  _enableAutoHide: ->
    $(document).on "mousedown.#{@id}", (e) =>
      return unless @active
      target = $ e.target
      return if target.is(@target) or $(@).has(target).length or target.is(@)
      @active = false

  _disableAutoHide: ->
    $(document).off "mousedown.#{@id}"

  refresh: ->
    @target = if @targetTraversal
      $(@)[@targetTraversal]?(@targetSelector)
    else
      $ @targetSelector

    return unless @target.length > 0
    @_refreshing = true

    direction = new Direction
      popover: $ @
      target: @target
      boundarySelector: @boundarySelector

    @direction = direction.toString()

    @position = new Position
      direction: direction
      arrowAlign: @arrowAlign
      arrowVerticalAlign: @arrowVerticalAlign
      offset: @offset

    $(@).css
      top: @position.top
      left: @position.left

    @_refreshing = false

  toggleActive: ->
    @active = !@active

  _disconnect: ->
    @_disableAutoHide()

TaoComponent.register TaoPopover.Component
