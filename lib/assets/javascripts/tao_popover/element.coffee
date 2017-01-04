#= require ./direction
#= require ./position

{Direction, Position} = TaoPopover

class TaoPopover.Element extends TaoComponent

  @tag: 'tao-popover'

  @attribute 'active', 'targetSelector', 'targetTraversal', 'boundarySelector', 'direction', 'arrowAlign', 'arrowVerticalAlign', observe: true

  @attribute 'offset', observe: true, default: 5

  @attribute 'autoHide', default: true

  _init: ->
    @jq.wrapInner '<div class="tao-popover-content">'
      .append '''
        <div class="tao-popover-arrow">
          <i class="arrow arrow-shadow"></i>
          <i class="arrow arrow-border"></i>
          <i class="arrow arrow-basic"></i>
        </div>
      '''

  _connected: ->
    @_autoHideChanged()
    @refresh() if @active

  _activeChanged: ->
    if @active
      @refresh()
      @_enableAutoHide() if @autoHide
    else
      @_disableAutoHide() if @autoHide

  _autoHideChanged: ->
    @_disableAutoHide()
    @_enableAutoHide() if @autoHide && @active

  _enableAutoHide: ->
    $(document).on "mousedown.tao-popover-#{@taoId}", (e) =>
      return unless @active
      target = $ e.target
      return if target.is(@target) or @jq.has(target).length or target.is(@)
      @active = false

  _disableAutoHide: ->
    $(document).off "mousedown.tao-popover-#{@taoId}"

  refresh: ->
    @target = if @targetTraversal && @targetSelector
      @jq[@targetTraversal]?(@targetSelector)
    else if @targetSelector
      $ @targetSelector

    return unless @target && @target.length > 0

    direction = new Direction
      popover: @jq
      target: @target
      boundarySelector: @boundarySelector
    @direction = direction.toString()

    @position = new Position
      popover: @jq
      target: @target
      direction: @direction.split('-')
      arrowAlign: @arrowAlign
      arrowVerticalAlign: @arrowVerticalAlign
      offset: @offset

    @jq.css
      top: @position.top
      left: @position.left

  toggleActive: ->
    @active = !@active

  _disconnected: ->
    @_disableAutoHide()

TaoComponent.register TaoPopover.Element
