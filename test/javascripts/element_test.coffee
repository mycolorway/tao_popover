{module, test} = QUnit

module 'TaoPopover.Element',

  beforeEach: ->
    @target = $('''
      <span class="popover-target">Target</span>
    ''').appendTo 'body'
    @popover = $('''
      <tao-popover target-selector=".popover-target">hahaha</tao-popover>
    ''').appendTo('body').get(0)

  afterEach: ->
    @target.remove()
    @popover.jq.remove()
    @popover = null

, ->

  test 'inherits from TaoComponent', (assert) ->
    assert.ok @popover instanceof TaoComponent

  test 'active property', (assert) ->
    assert.equal @popover.active, false
    assert.notOk @popover.hasAttribute('active')
    assert.equal @popover.direction, false
    assert.notOk @popover.target

    @popover.active = true
    assert.equal @popover.active, true
    assert.ok @popover.hasAttribute('active')
    assert.equal @popover.direction, 'right-middle'
    assert.equal @popover.target.get(0), @target.get(0)
