#= require ./element

class TaoPopover.Trigger extends TaoComponent

  @tag: 'tao-popover-trigger'

  @attribute 'triggerAction', observe: true, default: 'click'

  @attribute 'triggerSelector', observe: true, default: 'a, button'

  _init: ->
    @popover = @jq.children('tao-popover').get(0)
    @popover.active = false
    @popover.autoHide = @triggerAction == 'click'

    @popover.targetSelector = '*' unless @popover.targetSelector
    @popover.targetTraversal = 'prev' unless @popover.targetTraversal

  _connected: ->
    @_bindTriggerEvent()

  _disconnected: ->
    @off '.tao-popover-trigger'

  _bindTriggerEvent: ->
    @off '.tao-popover-trigger'

    if @triggerAction == 'click'
      @on 'click.tao-popover-trigger', "> #{@triggerSelector}", (e) =>
        @popover.toggleActive()
        false
    else if @triggerAction == 'hover'
      @on 'mouseenter.tao-popover-trigger', "> #{@triggerSelector}", (e) =>
        @popover.active = true
      .on 'mouseleave.tao-popover-trigger', "> #{@triggerSelector}", (e) =>
        @popover.active = false

  _triggerActionChanged: ->
    @_popover = null
    @_bindTriggerEvent()

  _triggerSelectorChanged: ->
    @_bindTriggerEvent()


TaoComponent.register TaoPopover.Trigger
