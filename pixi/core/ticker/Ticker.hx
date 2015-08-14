package pixi.core.ticker;

import pixi.interaction.EventEmitter;

@:native("PIXI.ticker.Ticker")
extern class Ticker extends EventEmitter {

	/**
	 * A Ticker class that runs an update loop that other objects listen to.
	 * This class is composed around an EventEmitter object to add listeners
	 * meant for execution on the next requested animation frame.
	 * Animation frames are requested only when necessary,
	 * e.g. When the ticker is started and the emitter has listeners.
	 *
	 * @class
	 * @memberof PIXI.ticker
	 */
	function new();

	/**
     * Whether or not this ticker should invoke the method
     * {@link PIXI.ticker.Ticker#start} automatically
     * when a listener is added.
     *
     * @member {Bool}
     * @default false
     */
	var autoStart:Bool;

	/**
     * Scalar time value from last frame to this frame.
     * This value is capped by setting {@link PIXI.ticker.Ticker#minFPS}
     * and is scaled with {@link PIXI.ticker.Ticker#speed}.
     * **Note:** The cap may be exceeded by scaling.
     *
     * @member {Float}
     * @default 1
     */
	var deltaTime:Float;

	/**
     * Time elapsed in milliseconds from last frame to this frame.
     * Opposed to what the scalar {@link PIXI.ticker.Ticker#deltaTime}
     * is based, this value is neither capped nor scaled.
     * If the platform supports DOMHighResTimeStamp,
     * this value will have a precision of 1 µs.
     *
     * @member {Float}
     * @default 1 / TARGET_FPMS
     */
	var elapsedMS:Float;

	/**
     * The last time {@link PIXI.ticker.Ticker#update} was invoked.
     * This value is also reset internally outside of invoking
     * update, but only when a new animation frame is requested.
     * If the platform supports DOMHighResTimeStamp,
     * this value will have a precision of 1 µs.
     *
     * @member {Float}
     * @default 0
     */
	var lastTime:Float;

	/**
     * Factor of current {@link PIXI.ticker.Ticker#deltaTime}.
     * @example
     *     // Scales ticker.deltaTime to what would be
     *     // the equivalent of approximately 120 FPS
     *     ticker.speed = 2;
     *
     * @member {Float}
     * @default 1
     */
	var speed:Float;

	/**
     * Whether or not this ticker has been started.
     * `true` if {@link PIXI.ticker.Ticker#start} has been called.
     * `false` if {@link PIXI.ticker.Ticker#stop} has been called.
     * While `false`, this value may change to `true` in the
     * event of {@link PIXI.ticker.Ticker#autoStart} being `true`
     * and a listener is added.
     *
     * @member {Bool}
     * @default false
     */
	var started:Bool;

	/**
     * The frames per second at which this ticker is running.
     * The default is approximately 60 in most modern browsers.
     * **Note:** This does not factor in the value of
     * {@link PIXI.ticker.Ticker#speed}, which is specific
     * to scaling {@link PIXI.ticker.Ticker#deltaTime}.
     *
     * @member
     * @memberof PIXI.ticker.Ticker#
     * @readonly
     */
	var FPS:Int;

	/**
     * Manages the maximum amount of milliseconds allowed to
     * elapse between invoking {@link PIXI.ticker.Ticker#update}.
     * This value is used to cap {@link PIXI.ticker.Ticker#deltaTime},
     * but does not effect the measured value of {@link PIXI.ticker.Ticker#FPS}.
     * When setting this property it is clamped to a value between
     * `0` and `PIXI.TARGET_FPMS * 1000`.
     *
     * @member
     * @memberof PIXI.ticker.Ticker#
     * @default 10
     */
	var minFPS:Int;

	/**
	 * Starts the ticker. If the ticker has listeners
	 * a new animation frame is requested at this point.
	 */
	function start():Void;

	/**
	 * Stops the ticker. If the ticker has requested
	 * an animation frame it is canceled at this point.
	 */
	function stop():Void;

	/**
	 * Triggers an update. An update entails setting the
	 * current {@link PIXI.ticker.Ticker#elapsedMS},
	 * the current {@link PIXI.ticker.Ticker#deltaTime},
	 * invoking all listeners with current deltaTime,
	 * and then finally setting {@link PIXI.ticker.Ticker#lastTime}
	 * with the value of currentTime that was provided.
	 * This method will be called automatically by animation
	 * frame callbacks if the ticker instance has been started
	 * and listeners are added.
	 *
	 * @param [currentTime=performance.now()] {DOMHighResTimeStamp|number} the current time of execution
	 */
	function update(?currentTime:Float):Void;
}