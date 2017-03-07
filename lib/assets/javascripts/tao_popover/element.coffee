#= require ./direction
#= require ./position

{Direction, Position} = TaoPopover

class TaoPopover.Element extends TaoComponent

  @tag: 'tao-popover'

  @attribute 'active', type: 'boolean', observe: true

  @attribute 'targetSelector', 'targetTraversal', 'triggerSelector', 'triggerTraversal'

  @attribute 'triggerAction', default: 'click'

  @attribute 'boundarySelector', 'direction', 'arrowAlign', 'arrowVerticalAlign'

  @attribute 'offset', type: 'number', default: 0

  @attribute 'autoHide', type: 'boolean', default: true

  _init: ->
    @target = if @targetTraversal && @targetSelector
      @jq[@targetTraversal]?(@targetSelector)
    else if @targetSelector
      $ @targetSelector

    unless @target.length > 0
      throw new Error 'tao-popover: targetSelector attribute is required.'
      return

    @trigger = if @triggerTraversal && @triggerSelector
      @jq[@triggerTraversal]?(@triggerSelector)
    else if @triggerSelector
      $ @triggerSelector
    else
      @target

    @_bind()

  _connected: ->
    @refresh() if @active
    @_enableAutoHide() if @autoHide && @active

  _bind: ->
    if @triggerAction == 'click'
      @trigger.on 'click.tao-popover', (e) =>
        @toggleActive()
    else if @triggerAction == 'hover'
      @trigger.on 'mouseenter.tao-popover', (e) =>
        @active = true
      .on 'mouseleave.tao-popover', (e) =>
        @active = false

  _activeChanged: ->
    if @active
      @refresh()
      @_enableAutoHide() if @autoHide
    else
      @_disableAutoHide() if @autoHide

  _enableAutoHide: ->
    $(document).on "mousedown.tao-popover-#{@taoId}", (e) =>
      return unless @active
      target = $ e.target
      return if target.is(@target) or @jq.has(target).length or target.is(@)
      @active = false

  _disableAutoHide: ->
    $(document).off "mousedown.tao-popover-#{@taoId}"

  refresh: ->
    unless @direction
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
    @trigger.off '.tao-popover'
    $(document).off ".tao-popover-#{@taoId}"

TaoComponent.register TaoPopover.Element
