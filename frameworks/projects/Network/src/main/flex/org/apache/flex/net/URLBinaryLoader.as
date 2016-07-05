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
package org.apache.flex.net
{    
    
    import org.apache.flex.events.Event;
    import org.apache.flex.events.ProgressEvent;
    import org.apache.flex.utils.BinaryData;
    import org.apache.flex.utils.Endian;


	/**
	 *  The BinaryUploader class is a relatively low-level class designed to get
	 *  binary data over HTTP the intent is to create similar classes for text and URL vars.  
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.7.0
	 */
   public class URLBinaryLoader extends URLLoader
    {
        
	   /**
		*  The binary result of the request.
		*  
		*  @langversion 3.0
		*  @playerversion Flash 10.2
		*  @playerversion AIR 2.6
		*  @productversion FlexJS 0.7.0
		*/        
        public var data:BinaryData;

		/**
		 *  The status of the request.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.7.0
		 */        
		public var status:String;
		
		/**
		 *  Indicates the byte order for the data.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.7.0
		 */        
		public var endian:String = Endian.BIG_ENDIAN;
		

        private var stream:URLStream;
        
		/**
		 *  The number of bytes loaded so far.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.7.0
		 */        
        public var bytesLoaded:uint = 0;
        
		/**
		 *  The total number of bytes (if avaailable).
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.7.0
		 */        
        public var bytesTotal:uint = 0;
        
        public function URLBinaryLoader(request:URLRequest = null)
        {
            super();
            stream = new URLStream();
            stream.addEventListener(HTTPConstants.COMPLETE, completeHandler);
        }
        
		/**
		 *  Makes the URL request.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.7.0
		 */        
        public function load(request:URLRequest):void
        {
            stream.load(request);
        }
        
		/**
		 *  Cancels the URL request
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.7.0
		 */        
        public function close():void
        {
            stream.close();
			//TODO do we need a callback for camceling?
        }
        
        private function completeHandler(event:Event):void
        {
            data = stream.response;
            if (data)
            {
                dispatchEvent(event);
				if(onComplete)
					onComplete(this);

            }
            else
            {
                // TODO dipatch error event?
                dispatchEvent(new Event(HTTPConstants.IO_ERROR));
				if(onError)
					onError(this);
            }
			cleanupCallbacks();
        }
        
        private function progressHandler(event:ProgressEvent):void
        {
            this.bytesLoaded = event.current
            this.bytesTotal = event.total;
            dispatchEvent(event);
			if(onProgress)
				onProgress(this);
        }
    }
}
