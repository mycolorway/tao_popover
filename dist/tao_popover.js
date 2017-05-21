(function() {
  window.TaoPopover = {};

}).call(this);
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  TaoPopover.Direction = (function(superClass) {
    extend(Direction, superClass);

    function Direction() {
      return Direction.__super__.constructor.apply(this, arguments);
    }

    Direction.option('popover', 'target', 'boundarySelector');

    Direction.prototype._init = function() {
      this.boundary = this.boundarySelector ? this.target.closest(this.boundarySelector) : $(window);
      return this._calculate();
    };

    Direction.prototype._calculate = function() {
      var coefficient, horizental, ref, ref1, vertical;
      coefficient = this._beyondCoefficient();
      vertical = (coefficient.bottom > 0 && coefficient.top > 0) || (coefficient.bottom === (ref = coefficient.top) && ref === 0) ? 'middle' : coefficient.bottom > 0 ? 'top' : 'bottom';
      horizental = (coefficient.left > 0 && coefficient.right > 0) || (coefficient.left === (ref1 = coefficient.right) && ref1 === 0) ? vertical === 'middle' ? 'right' : 'center' : coefficient.right > 0 ? 'left' : 'right';
      return this.directions = vertical === 'middle' ? [horizental, vertical] : horizental === 'center' ? [vertical, horizental] : coefficient[vertical] > coefficient[horizental] ? [horizental, vertical] : [vertical, horizental];
    };

    Direction.prototype._beyondCoefficient = function() {
      var beyondOffset, boundaryDimensions, boundaryHeight, boundaryWidth, popoverHeight, popoverWidth, targetDimensions;
      targetDimensions = this._getDimensions(this.target);
      boundaryDimensions = this._getDimensions(this.boundary);
      popoverWidth = this.popover.outerWidth();
      popoverHeight = this.popover.outerHeight();
      boundaryWidth = this.boundary.width();
      boundaryHeight = this.boundary.height();
      beyondOffset = ['left', 'right', 'top', 'bottom'].reduce(function(offset, name) {
        offset[name] = targetDimensions[name] - boundaryDimensions[name];
        return offset;
      }, {});
      return {
        left: Math.max(popoverWidth - beyondOffset.left, 0) * popoverHeight + Math.max(popoverHeight - boundaryHeight, 0) * popoverWidth,
        right: Math.max(popoverWidth - beyondOffset.right, 0) * popoverHeight + Math.max(popoverHeight - boundaryHeight, 0) * popoverWidth,
        top: Math.max(popoverHeight - beyondOffset.top, 0) * popoverWidth + Math.max(popoverWidth - boundaryWidth, 0) * popoverHeight,
        bottom: Math.max(popoverHeight - beyondOffset.bottom, 0) * popoverWidth + Math.max(popoverWidth - boundaryWidth, 0) * popoverHeight
      };
    };

    Direction.prototype._getDimensions = function($el) {
      var $window, offset;
      if ($el[0] === window) {
        return {
          left: 0,
          right: 0,
          top: 0,
          bottom: 0
        };
      }
      $window = $(window);
      offset = $el.offset();
      return {
        left: offset.left - $window.scrollLeft(),
        right: $window.scrollLeft() + $window.width() - offset.left - $el.outerWidth(),
        top: offset.top - $window.scrollTop(),
        bottom: $window.scrollTop() + $window.height() - offset.top - $el.outerHeight()
      };
    };

    Direction.prototype.toString = function() {
      return this.directions.join('-');
    };

    return Direction;

  })(TaoModule);

}).call(this);
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  TaoPopover.Position = (function(superClass) {
    extend(Position, superClass);

    function Position() {
      return Position.__super__.constructor.apply(this, arguments);
    }

    Position.option('direction', 'popover', 'target');

    Position.option('arrowAlign', {
      "default": 'center'
    });

    Position.option('arrowVerticalAlign', {
      "default": 'middle'
    });

    Position.option('offset', {
      "default": 0
    });

    Position.prototype.ARROW_OFFSET = 16;

    Position.prototype._init = function() {
      this.top = 0;
      this.left = 0;
      this._setPosition();
      this._setArrowAlign();
      return this._setOffset();
    };

    Position.prototype._setPosition = function() {
      var $arrow, arrowHeight, arrowWidth, parentOffset, popoverHeight, popoverWidth, targetHeight, targetOffset, targetWidth;
      targetOffset = this.target.offset();
      targetWidth = this.target.outerWidth();
      targetHeight = this.target.outerHeight();
      popoverWidth = this.popover.outerWidth();
      popoverHeight = this.popover.outerHeight();
      parentOffset = this.popover.offsetParent().offset();
      $arrow = this.popover.find('.tao-popover-arrow');
      arrowWidth = $arrow.outerWidth();
      arrowHeight = $arrow.outerHeight();
      switch (this.direction[0]) {
        case 'left':
          this.left = targetOffset.left - popoverWidth - arrowWidth - parentOffset.left;
          break;
        case 'right':
          this.left = targetOffset.left + targetWidth + arrowWidth - parentOffset.left;
          break;
        case 'top':
          this.top = targetOffset.top - popoverHeight - arrowHeight - parentOffset.top;
          break;
        case 'bottom':
          this.top = targetOffset.top + targetHeight + arrowHeight - parentOffset.top;
      }
      switch (this.direction[1]) {
        case 'top':
          return this.top = targetOffset.top - popoverHeight + targetHeight / 2 + arrowHeight / 2 + this.ARROW_OFFSET - parentOffset.top;
        case 'bottom':
          return this.top = targetOffset.top + targetHeight / 2 - arrowHeight / 2 - this.ARROW_OFFSET - parentOffset.top;
        case 'left':
          return this.left = targetOffset.left - popoverWidth + targetWidth / 2 + arrowWidth / 2 + this.ARROW_OFFSET - parentOffset.left;
        case 'right':
          return this.left = targetOffset.left + targetWidth / 2 - arrowWidth / 2 - this.ARROW_OFFSET - parentOffset.left;
        case 'center':
          return this.left = targetOffset.left + targetWidth / 2 - popoverWidth / 2 - parentOffset.left;
        case 'middle':
          return this.top = targetOffset.top + targetHeight / 2 - popoverHeight / 2 - parentOffset.top;
      }
    };

    Position.prototype._setArrowAlign = function() {
      if (/top|bottom/.test(this.direction[0])) {
        switch (this.arrowAlign) {
          case 'left':
            this.left -= this.target.width() / 2;
            break;
          case 'right':
            this.left += this.target.width() / 2;
        }
      }
      if (/left|right/.test(this.direction[0])) {
        switch (this.arrowVerticalAlign) {
          case 'top':
            return this.top -= this.target.height() / 2;
          case 'bottom':
            return this.top += this.target.height() / 2;
        }
      }
    };

    Position.prototype._setOffset = function() {
      if (!this.offset) {
        return;
      }
      switch (this.direction[0]) {
        case 'top':
          return this.top -= this.offset;
        case 'bottom':
          return this.top += this.offset;
        case 'left':
          return this.left -= this.offset;
        case 'right':
          return this.left += this.offset;
      }
    };

    return Position;

  })(TaoModule);

}).call(this);
(function() {
  var Direction, Position,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Direction = TaoPopover.Direction, Position = TaoPopover.Position;

  TaoPopover.Element = (function(superClass) {
    extend(Element, superClass);

    function Element() {
      return Element.__super__.constructor.apply(this, arguments);
    }

    Element.tag('tao-popover');

    Element.attribute('active', {
      type: 'boolean',
      observe: true
    });

    Element.attribute('targetSelector', 'targetTraversal', 'triggerSelector', 'triggerTraversal');

    Element.attribute('triggerAction', {
      "default": 'click'
    });

    Element.attribute('boundarySelector', 'direction', 'arrowAlign', 'arrowVerticalAlign');

    Element.attribute('offset', {
      type: 'number',
      "default": 0
    });

    Element.attribute('autoHide', {
      type: 'boolean',
      "default": true
    });

    Element.prototype._connected = function() {
      var base, base1, name, name1;
      this.target = this.targetTraversal && this.targetSelector ? typeof (base = this.jq)[name = this.targetTraversal] === "function" ? base[name](this.targetSelector) : void 0 : this.targetSelector ? $(this.targetSelector) : void 0;
      if (!(this.target.length > 0)) {
        throw new Error('tao-popover: targetSelector attribute is required.');
        return;
      }
      this.triggerEl = this.triggerTraversal && this.triggerSelector ? typeof (base1 = this.jq)[name1 = this.triggerTraversal] === "function" ? base1[name1](this.triggerSelector) : void 0 : this.triggerSelector ? $(this.triggerSelector) : this.target;
      this._bind();
      if (this.active) {
        this.refresh();
      }
      if (this.autoHide && this.active) {
        return this._enableAutoHide();
      }
    };

    Element.prototype._bind = function() {
      if (this.triggerAction === 'click') {
        return this.triggerEl.on('click.tao-popover', (function(_this) {
          return function(e) {
            return _this.toggleActive();
          };
        })(this));
      } else if (this.triggerAction === 'hover') {
        return this.triggerEl.on('mouseenter.tao-popover', (function(_this) {
          return function(e) {
            return _this.active = true;
          };
        })(this)).on('mouseleave.tao-popover', (function(_this) {
          return function(e) {
            return _this.active = false;
          };
        })(this));
      }
    };

    Element.prototype._activeChanged = function() {
      if (this.active) {
        this.refresh();
        if (this.autoHide) {
          return this._enableAutoHide();
        }
      } else {
        if (this.autoHide) {
          return this._disableAutoHide();
        }
      }
    };

    Element.prototype._enableAutoHide = function() {
      return $(document).on("mousedown.tao-popover-" + this.taoId, (function(_this) {
        return function(e) {
          var target;
          if (!_this.active) {
            return;
          }
          target = $(e.target);
          if (target.is(_this.target) || _this.jq.has(target).length || target.is(_this)) {
            return;
          }
          return _this.active = false;
        };
      })(this));
    };

    Element.prototype._disableAutoHide = function() {
      return $(document).off("mousedown.tao-popover-" + this.taoId);
    };

    Element.prototype.refresh = function() {
      var direction;
      if (!this.direction) {
        direction = new Direction({
          popover: this.jq,
          target: this.target,
          boundarySelector: this.boundarySelector
        });
        this.direction = direction.toString();
      }
      this.position = new Position({
        popover: this.jq,
        target: this.target,
        direction: this.direction.split('-'),
        arrowAlign: this.arrowAlign,
        arrowVerticalAlign: this.arrowVerticalAlign,
        offset: this.offset
      });
      return this.jq.css({
        top: this.position.top,
        left: this.position.left
      });
    };

    Element.prototype.toggleActive = function() {
      return this.active = !this.active;
    };

    Element.prototype._disconnected = function() {
      this.triggerEl.off('.tao-popover');
      return $(document).off(".tao-popover-" + this.taoId);
    };

    return Element;

  })(TaoComponent);

  TaoComponent.register(TaoPopover.Element);

}).call(this);
(function() {
  TaoPopover.create = function(attributes, content) {
    var $popover;
    $popover = $('<tao-popover class="tao-popover">\n  <div class="tao-popover-content">\n  </div>\n  <div class="tao-popover-arrow">\n    <i class="arrow arrow-shadow"></i>\n    <i class="arrow arrow-border"></i>\n    <i class="arrow arrow-basic"></i>\n  </div>\n</tao-popover>').attr(attributes);
    $popover.find('.tao-popover-content').append(content);
    return $popover.get(0);
  };

}).call(this);
