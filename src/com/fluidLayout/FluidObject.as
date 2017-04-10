﻿package com.fluidLayout{	/* class needed on resize Event */	import com.greensock.TweenLite;	import com.surnia.socialStar.controllers.EventSatellite;	import fl.transitions.*;	import fl.transitions.easing.*;	import flash.display.*;	import flash.events.*;	/* classes needed for MovieClip and DisplayObject */	/* classes needed for Easing Animation */	public class FluidObject {				/* alignment parameters */		protected var _param:Object;		/* target object to be monitored */		protected var _target:DisplayObject;		/* stage instance of the flash document */		protected var _stage:Stage;		/* Setter for the alignment param */		public function set param(value:Object):void {			_param=value;			this.reposition();		}		/* Constructor of the class */		public function FluidObject(target:DisplayObject,paramObj:Object) {			/* Assign the instance variables */			_target=target;			_param=paramObj;			_stage=target.stage;			/* add event handler for stage resize */			_stage.addEventListener(Event.RESIZE,onStageResize);			/* reposition the object with the alignment setting applied*/			this.reposition();		}		/* Function that reposition the monitored object */		protected function reposition():void {			/* get the current width and height of the flash document */			var stageW=_stage.stageWidth;			var stageH=_stage.stageHeight;			/* update the x and y value of the monitored object */			/* set the duration of the easing animation (seconds) */			var duration=0.5;			/* declare the new X/Y value */			var newX=_target.x;			var newY=_target.y;			/* calculate the new X value based on the stage Width */			if (_param.x!=undefined) {				newX = (stageW * _param.x) + _param.offsetX;			}			/* calculate the new Y value based on the stage Height */			if (_param.y!=undefined) {				newY = (stageH * _param.y) + _param.offsetY;			}			/* Tell flash to tween the target object to the new X/Y position */			new Tween(_target,"x",Strong.easeOut,_target.x,newX,duration,true);			new Tween(_target, "y", Strong.easeOut, _target.y, newY, duration, true);						TweenLite.delayedCall( duration, tweenEnd );		}				protected function tweenEnd():void {			//trace( "[FlowLayout] tween end!!" );			var fluidLayoutEvent:FluidLayoutEvent = new FluidLayoutEvent( FluidLayoutEvent.DONE_TWEENING );			var es:EventSatellite = EventSatellite.getInstance();			es.dispatchESEvent( fluidLayoutEvent );		}				protected function onStageResize(e):void {			/* reposition the target */			this.reposition();		}	}}