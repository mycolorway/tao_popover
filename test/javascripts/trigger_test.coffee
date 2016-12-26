{module, test} = QUnit

module 'TaoPopover.Trigger',

  beforeEach: ->
    @trigger = $('''
      <tao-popover-trigger>
        <a href="javascript:;">click me</a>
        <tao-popover>
          lalala
        </tao-popover>
      </tao-popover-trigger>
    ''').appendTo('body').get(0)

  afterEach: ->
    @trigger.jq.remove()
    @trigger = null

, ->

  test 'inherits from TaoComponent', (assert) ->
    assert.ok @trigger instanceof TaoComponent

  test 'child popover', (assert) ->
    assert.equal @trigger.popover, @trigger.jq.children('tao-popover').get(0)

  test 'trigger action', (assert) ->
    $triggerEl = @trigger.jq.children('a')
    assert.equal @trigger.triggerAction, 'click'
    assert.notOk @trigger.popover.active

    $triggerEl.click()
    assert.ok @trigger.popover.active
    $triggerEl.click()
    assert.notOk @trigger.popover.active

    @trigger.triggerAction = 'hover'
    assert.notOk @trigger.popover.active

    $triggerEl.mouseenter()
    assert.ok @trigger.popover.active
    $triggerEl.mouseleave()
    assert.notOk @trigger.popover.active
