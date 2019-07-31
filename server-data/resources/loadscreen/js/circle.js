"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
        function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var BasicVector = /** @class */ (function () {
    function BasicVector(options) {
        this._x = 0;
        this._y = 0;
        if (options) {
            if (options.x)
                this._x = options.x;
            if (options.y)
                this._y = options.y;
        }
    }
    Object.defineProperty(BasicVector.prototype, "x", {
        get: function () { return this._x; },
        enumerable: true,
        configurable: true
    });
    ;
    Object.defineProperty(BasicVector.prototype, "y", {
        get: function () { return this._y; },
        enumerable: true,
        configurable: true
    });
    ;
    return BasicVector;
}());
var MouseVector = /** @class */ (function (_super) {
    __extends(MouseVector, _super);
    function MouseVector(options) {
        var _this = _super.call(this, options) || this;
        _this._xDirection = "";
        _this._yDirection = "";
        var listener = document;
        if (options) {
            if (options.listener)
                listener = options.listener;
        }
        listener.addEventListener("mousemove", _this.onMouseMove.bind(_this), false);
        listener.addEventListener("touchmove", _this.onMouseMove.bind(_this), false);
        return _this;
    }
    Object.defineProperty(MouseVector.prototype, "xDirection", {
        get: function () { return this._xDirection; },
        enumerable: true,
        configurable: true
    });
    ;
    Object.defineProperty(MouseVector.prototype, "yDirection", {
        get: function () { return this._yDirection; },
        enumerable: true,
        configurable: true
    });
    ;
    MouseVector.prototype.onMouseMove = function (event) {
        var oldx = this.x;
        var oldy = this.y;
        this._x = event.clientX;
        this._y = event.clientY;
        this._xDirection = this.x > oldx ? "right" : "left";
        this._yDirection = this.y > oldy ? "down" : "up";
        document.dispatchEvent(new CustomEvent("mousevector-move", { detail: this }));
    };
    return MouseVector;
}(BasicVector));
var Attractor = /** @class */ (function () {
    function Attractor(options) {
        var _this = this;
        this.hasReachedPosition = false;
        this.canInteract = false;
        this.limitTo = "xy";
        this.xVector = 0;
        this.yVector = 0;
        this.bounceFriction = 0.85;
        this.spring = 0.1;
        this.easeSpeed = 0.3;
        this.el = options.el;

        this.rangeOfAttraction = options.rangeOfAttraction ? options.rangeOfAttraction : 0.5;
        this.area = parseInt(window.getComputedStyle(this.el, null).getPropertyValue("width"), 10);
        document.addEventListener("mousevector-move", this.onMouseMove.bind(this), false);
        setTimeout(function () { return _this.renderQueCall(); }, 0);
    }
    Object.defineProperty(Attractor.prototype, "xCenter", {
        get: function () {
            return window.innerWidth * 0.5;
        },
        enumerable: true,
        configurable: true
    });
    ;
    Object.defineProperty(Attractor.prototype, "yCenter", {
        get: function () {
            return window.innerHeight * 0.5;
        },
        enumerable: true,
        configurable: true
    });
    ;
    Attractor.prototype.onMouseMove = function (event) {
        if (this.canInteract && !this.onAnimatedCallback) {
            var vector = event.detail;
            var x = this.xCenter - vector.x;
            var y = this.yCenter - vector.y;
            this.xTarget = x / this.area;
            this.yTarget = y / this.area;
            this.xTarget *= this.area * -1;
            this.yTarget *= this.area * -1;
            var range = this.area * this.rangeOfAttraction;
            if (this.xTarget > range || this.xTarget < -range || this.yTarget > range || this.yTarget < -range) {

                this.xTarget = this.xCenter;
                this.yTarget = this.yCenter;
            }
            else {

                this.xTarget *= 0.5;
                this.yTarget *= 0.5;

                this.xTarget += this.xCenter;
                this.yTarget += this.yCenter;
            }

            this.hasReachedPosition = false;
        }
    };
    Attractor.prototype.renderQueCall = function () {
        var _this = this;
        if (this.userInteracting) {

            var mouseVector_1 = window.mouseVector;
            this.xTarget = mouseVector_1.x - this.startOffsetVector.x;
            this.yTarget = mouseVector_1.y - this.startOffsetVector.y;
            this.x += (this.xTarget - this.x) * this.easeSpeed;
            this.y += (this.yTarget - this.y) * this.easeSpeed;
        }
        else {
            this.xVector += (this.xTarget - this.x) * this.spring;
            this.yVector += (this.yTarget - this.y) * this.spring;
            this.x += (this.xVector *= this.bounceFriction);
            this.y += (this.yVector *= this.bounceFriction);
        }
        if (Math.abs(this.x - this.xTarget) < 0.1 && Math.abs(this.y - this.yTarget) < 0.1 && !this.hasReachedPosition) {
            this.hasReachedPosition = true;
            if (!this.canInteract && this.onAnimatedCallback) {
                this.onAnimatedCallback();
            }
        }
        var x = this.x - this.xCenter;
        var y = this.y - this.yCenter;
        this.setPosition(x, y);
        requestAnimationFrame(function () { return _this.renderQueCall(); });
    };
    Attractor.prototype.setPosition = function (x, y) {
        if (this.limitTo == "xy") {
            TweenMax.set(this.el, {
                force3D: true,
                x: x,
                y: y
            });
        }
        else if (this.limitTo == "x") {
            TweenMax.set(this.el, {
                force3D: true,
                x: x
            });
        }
        else if (this.limitTo == "y") {
            TweenMax.set(this.el, {
                force3D: true,
                y: y
            });
        }
    };
    Attractor.prototype.animateIn = function () {
        this.hasReachedPosition = false;
        this.x = this.xTarget = this.xCenter;
        this.y = this.yTarget = this.yCenter;
        this.onAnimatedCallback = this.onAnimatedIn;
    };
    Attractor.prototype.onAnimatedIn = function () {
        this.canInteract = true;
        this.onAnimatedCallback = null;
    };
    return Attractor;
}());
var Circle = /** @class */ (function (_super) {
    __extends(Circle, _super);
    function Circle(options) {
        var _this = _super.call(this, options) || this;
        _this.productTestIndex = 0;
        _this.innerEl = _this.el.getElementsByTagName("inner")[0];
        _this.el.addEventListener("mousedown", _this.onMouseDown.bind(_this), false);
        _this.el.addEventListener("mouseup", _this.onMouseUp.bind(_this), false);
        document.addEventListener("mouseup", _this.onMouseUp.bind(_this), false);
        _this.area = 300;
        _this.animateIn();
        return _this;
    }
    Circle.prototype.animateIn = function () {
        _super.prototype.animateIn.call(this);
        this.el.classList.remove("product-" + this.productTestIndex);
        this.productTestIndex++;
        this.productTestIndex %= 2;
        this.el.classList.add("product-" + this.productTestIndex);
        this.limitTo = "xy";
        this.el.classList.add("show");
        this.y = this.yTarget = this.area * -1;
        TweenMax.set(this.el, {
            force3D: true,
            x: this.xCenter,
            y: this.y
        });
        this.yTarget = this.yCenter;
    };
    Circle.prototype.renderQueCall = function () {
        _super.prototype.renderQueCall.call(this);
        var halfw = window.innerWidth * 0.5;
        var halfh = window.innerHeight * 0.5;
        var x = this.x - this.xCenter;
        document.dispatchEvent(new CustomEvent("circle-move", {
            detail: {
                percent: x / window.innerWidth,
                userInteracting: this.userInteracting,
                canInteract: this.canInteract
            }
        }));

        var xShadow = 5 + (this.limitTo == "y" ? 0 : ((halfw - this.x) / halfw) * 200);
        var yShadow = 5 + (this.limitTo == "x" ? 0 : ((halfh - this.y) / halfh) * 200);
        var blur = 50;
        var spread = 20;
        var box = xShadow + "px " + yShadow + "px " + blur + "px " + spread + "px rgb(158, 117, 177, 0.75)";
        TweenMax.set(this.innerEl, {
            boxShadow: box
        });
    };
    Circle.prototype.onAnimatedIn = function () {
        if (this.y !== undefined) {

            if (Math.abs(this.y - (window.innerHeight * 0.5)) < 0.1) {

                _super.prototype.onAnimatedIn.call(this);
            }
        }
    };
    Circle.prototype.onAnimatedOut = function () {
        this.animateIn();
    };
    Circle.prototype.onMouseDown = function (event) {
        if (this.canInteract && !this.onAnimatedCallback) {
            this.userInteracting = true;
            var mouseVector_2 = window.mouseVector;
            this.startOffsetVector = new BasicVector({
                x: mouseVector_2.x - this.x,
                y: mouseVector_2.y - this.y
            });
        }
    };
    Circle.prototype.onMouseUp = function (event) {
        this.userInteracting = false;
        if (this.x < window.innerWidth * 0.4) {
            this.animateOut("left");
        }
        else if (this.x > window.innerWidth * 0.6) {
            this.animateOut("right");
        }
        else {
            this.xTarget = this.xCenter;
        }
        this.yTarget = this.yCenter;

        this.hasReachedPosition = false;
    };
    Circle.prototype.animateOut = function (towards) {
        this.userInteracting = false;
        if (towards == "left") {
            this.canInteract = false;
            this.onAnimatedCallback = this.onAnimatedOut;
            this.xTarget = this.area * -0.55;
            this.el.classList.remove("show");
        }
        else if (towards == "right") {
            this.canInteract = false;
            this.onAnimatedCallback = this.onAnimatedOut;
            this.xTarget = window.innerWidth + (this.area * 0.55);
            this.el.classList.remove("show");
        }
        this.yTarget = this.yCenter;
        this.hasReachedPosition = false;
    };
    return Circle;
}(Attractor));
var mouseVector = new MouseVector();
var circ = new Circle({
    el: document.getElementsByTagName("circle")[0],
    rangeOfAttraction: 1
});
