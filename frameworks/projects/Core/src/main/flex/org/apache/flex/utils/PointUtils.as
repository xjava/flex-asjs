////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.utils
{
    COMPILE::SWF
    {
        import flash.display.DisplayObject;
        import flash.geom.Point;
    }
    
    import org.apache.flex.core.IUIBase;
    import org.apache.flex.geom.Point;

	/**
	 *  The PointUtils class is a collection of static functions that convert
     *  Points between coordinate spaces.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class PointUtils
	{
		/**
		 * @private
		 */
		public function PointUtils()
		{
			throw new Error("PointUtils should not be instantiated.");
		}
		
		/**
		 *  Converts a point from global coordinates to local coordinates
		 * 
		 *  @param point The point being converted.
		 *  @param local The component used as reference for the conversion.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
         *  @flexjsignorecoercion HTMLElement
		 */
		public static function globalToLocal( pt:org.apache.flex.geom.Point, local:Object ):org.apache.flex.geom.Point
		{
            COMPILE::SWF
            {
                var fpt:flash.geom.Point = DisplayObject(local).globalToLocal(new flash.geom.Point(pt.x,pt.y));
                return new org.apache.flex.geom.Point(fpt.x, fpt.y);
            }
            COMPILE::JS
            {
                var x:Number = pt.x;
                var y:Number = pt.y;
                var element:HTMLElement = local.element as HTMLElement;
                
                do {
                    x -= element.offsetLeft;
                    y -= element.offsetTop;
                    if (local.hasOwnProperty('parent')) {
                        local = local.parent;
                        element = local.element as HTMLElement;
                    } else {
                        element = null;
                    }
                }
                while (element);
                return new org.apache.flex.geom.Point(x, y);

            }
		}
		
        /**
         *  Converts a point from local coordinates to global coordinates
         * 
         *  @param point The point being converted.
         *  @param local The component used as reference for the conversion.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         *  @flexjsignorecoercion HTMLElement
         */
        public static function localToGlobal( pt:org.apache.flex.geom.Point, local:Object ):org.apache.flex.geom.Point
        {
            COMPILE::SWF
            {
                var fpt:flash.geom.Point = DisplayObject(local).localToGlobal(new flash.geom.Point(pt.x,pt.y));
                return new org.apache.flex.geom.Point(fpt.x, fpt.y);
            }
            COMPILE::JS
            {
                var x:Number = pt.x;
                var y:Number = pt.y;
                var element:HTMLElement = local.element as HTMLElement;
                
                do {
                    x += element.offsetLeft;
                    y += element.offsetTop;
                    element = element.offsetParent as HTMLElement;
                }
                while (element);
                return new org.apache.flex.geom.Point(x, y);
            }
        }
	}
}
