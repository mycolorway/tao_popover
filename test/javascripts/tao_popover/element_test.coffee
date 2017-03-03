{module, test} = QUnit

module 'TaoPopover.Element',

  beforeEach: (assert) ->
    done = assert.async()

    @target = $('''
      <span class="popover-target">Target</span>
    ''').appendTo 'body'
    @popover = TaoPopover.create
      'target-selector': '.popover-target'
    , 'lalala'
    @popover.jq.appendTo 'body'

    setTimeout -> done()

  afterEach: ->
    @target.remove()
    @popover.jq.remove()
    @popover = null

, ->

  test 'inherits from TaoComponent', (assert) ->
    assert.ok @popover instanceof TaoComponent

  test 'active attribute', (assert) ->
    assert.equal @popover.active, false
    assert.notOk @popover.hasAttribute('active')
    assert.equal @popover.direction, ''
    assert.equal @popover.target.get(0), @target.get(0)

    @popover.active = true
    assert.equal @popover.active, true
    assert.ok @popover.hasAttribute('active')
    assert.equal @popover.direction, 'right-middle'
