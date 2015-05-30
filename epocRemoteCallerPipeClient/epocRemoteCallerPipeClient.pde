/**
* Epoc Remote Caller - Stephane Adam Garnier 2012
*
* allow user to remotely initiate a phone call to four different persons, only using the power of his will ;p
*
* Nb: to work properly, the setup needs Emotiv's "Epoc Control Panel" & Bitrayne's "Mind Your OSCs",
*     as well as this program (epocPipeServer) & its associated client (epocPipeClient).
*     Once setup properly, user can initiate facetime calls (using the 'initiate_facetime_call.rb' script), or even
*     initiate the call directly from their IOS device (using the 'epocMindCaller' application)
*/

import processing.net.*; // import the processing .net lib to our sketch (used to create a server <-> client 'pipe' for communication (here client part) )
Client epocPipeClient; // create an instance of the processing.net lib Server

String phoneNumberMsg = "";

void setup(){
  // usual init ..
  size(200, 200);
  smooth();
  
  // start an 'epocPipeClient' on localhost: 5204
  //epocPipeClient = new Client(this, "127.0.0.1", 5204); // when running on localhost (ex: server on Windows / Client on Mac OSX)
  //epocPipeClient = new Client(this, "192.168.1.7", 5204); // when running on macbookpro (on MacOS X Snow leopard)
  epocPipeClient = new Client(this, "192.168.1.13", 5204); // when running on macbookpro (on WinXP VM (VMWare on MacOS X Snow leopard) )
  
  println("[ epocPipeClient ] > epocPipeClient started.");
}

void draw(){
  
  //simple write to client (for the moment)
  readPhoneNumberMessage();
  
}

void readPhoneNumberMessage(){
  
  // check if the epocPipeClient is available
  if(epocPipeClient.available() > 0){
    
    // get the phone number message
    phoneNumberMsg = epocPipeClient.readString();
    println("[ epocPipeClient ] >" + " Phone number received: " + phoneNumberMsg);
    // do stuff with it:
      // initiate a facetime call using the phone number
      initiateFacetimeCall();
      // initiate an iPohne call using the pgone number
      initiateIphoneCall();
  }
  
}

void initiateFacetimeCall(){ // basically, just calling a ruby script and passing it two arguments
   println("[ epocPipeClient ] > " + "calling " + phoneNumberMsg + " using facetime");
  
  //String[] rubyExecParams = {"say", "calling ", phoneNumberMsg, " using facetime"}; // tested & working ;p
  //String[] rubyExecParams = {"ruby", "/users/stephanegarnier/imac_ruby_dev/remote_facetime_epoc/initiate_facetime_call.rb call", phoneNumberMsg};
  String[] rubyExecParams = {"ruby", "/users/stephanegarnier/imac_ruby_dev/remote_facetime_epoc/epoc_initiate_facetime_call.rb", "call", phoneNumberMsg};
  exec(rubyExecParams);
  
  
}

void initiateIphoneCall(){
  println("[ epocPipeClient ] > " + "calling " + phoneNumberMsg + "using IOS device");
}
