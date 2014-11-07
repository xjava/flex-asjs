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
package org.apache.flex.core
{
	import org.apache.flex.events.Event;
	import org.apache.flex.events.EventDispatcher;

    /**
     *  The BindableCSSStyles class contains CSS style
     *  properties supported by SimpleCSSValuesImpl but
     *  dispatch change events when modified
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
	public class BindableCSSStyles extends EventDispatcher
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function BindableCSSStyles()
		{
			super();
		}
		
		
		private var _object:IStyleableObject;
                
        /**
         *  The object to which these styles apply.
         * 
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get object():IStyleableObject
		{
			return _object;
		}
        
        /**
         *  @private
         */
		public function set object(value:IStyleableObject):void
		{
			if (_object != value)
			{
                _object = value;
			}
		}
		
        [Bindable]
        public var top:*;
        [Bindable]
        public var bottom:*;
        [Bindable]
        public var left:*;
        [Bindable]
        public var right:*;
        [Bindable]
        public var padding:*;
        [Bindable]
		public var paddingLeft:*;
        [Bindable]
        public var paddingRight:*;
        [Bindable]
        public var paddingTop:*;
        [Bindable]
        public var paddingBottom:*;
        [Bindable]
        public var margin:*;
        [Bindable]
        public var marginLeft:*;
        [Bindable]
        public var marginRight:*;
        [Bindable]
        public var marginTop:*;
        [Bindable]
        public var marginBottom:*;
        [Bindable]
        public var horizontalCenter:*;
        [Bindable]
        public var verticalCenter:*;
        [Bindable]
        public var horizontalAlign:*;
        [Bindable]
        public var verticalAlign:*;
        [Bindable]
        public var fontFamily:*;
        [Bindable]
        public var fontSize:*;
        [Bindable]
        public var color:*;
        [Bindable]
        public var fontWeight:*;
        [Bindable]
        public var fontStyle:*;
        [Bindable]
        public var backgroundAlpha:*;
        [Bindable]
        public var backgroundColor:*;
        [Bindable]
        public var backgroundImage:*;
        [Bindable]
        public var borderColor:*;
        [Bindable]
        public var borderStyle:*;
        [Bindable]
        public var borderRadius:*;
	}
}