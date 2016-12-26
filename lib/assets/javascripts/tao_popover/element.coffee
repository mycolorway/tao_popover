#= require ./direction
#= require ./position

{Direction, Position} = TaoPopover

class TaoPopover.Element extends TaoComponent

  @tag: 'tao-popover'

  @count: 0

  @property 'active', 'targetSelector', 'targetTraversal', 'boundarySelector', 'direction', 'arrowAlign', 'arrowVerticalAlign', observe: true

  @property 'offset', observe: true, default: 5

  @property 'autoHide', default: true

  _init: ->
    @id ||= "tao-popover-#{++@constructor.count}"
    @_render()

  _render: ->
    @jq.wrapInner '<div class="tao-popover-content">'
      .append '''
        <div class="tao-popover-arrow">
          <i class="arrow arrow-shadow"></i>
          <i class="arrow arrow-border"></i>
          <i class="arrow arrow-basic"></i>
        </div>
      '''

  _connect: ->
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
    $(document).on "mousedown.#{@id}", (e) =>
      return unless @active
      target = $ e.target
      return if target.is(@target) or @jq.has(target).length or target.is(@)
      @active = false

  _disableAutoHide: ->
    $(document).off "mousedown.#{@id}"

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

  _disconnect: ->
    @_disableAutoHide()

TaoComponent.register TaoPopover.Element
