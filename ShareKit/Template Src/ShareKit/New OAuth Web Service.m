//  Created by «FULLUSERNAME» on «DATE».


/*

 For a step by step guide to creating your service class, start at the top and move down through the comments.
 
*/


«OPTIONALHEADERIMPORTLINE»

@implementation «FILEBASENAMEASIDENTIFIER»


#pragma mark -
#pragma mark Configuration : Service Defination

// Enter the name of the service
+ (NSString *)sharerTitle
{
	return @"Name of Web Service";
}


// What types of content can the action handle?

// If the action can handle URLs, uncomment this section
/*
+ (BOOL)canShareURL
{
	return YES;
}
*/

// If the action can handle images, uncomment this section
/*
+ (BOOL)canShareImage
{
	return YES;
}
*/

// If the action can handle text, uncomment this section
/*
+ (BOOL)canShareText
{
	return YES;
}
*/

// If the action can handle files, uncomment this section
/*
+ (BOOL)canShareFile
{
	return YES;
}
*/


// Does the service require a login?  If for some reason it does NOT, uncomment this section:
/*
+ (BOOL)requiresAuthentication
{
	return NO;
}
*/ 


#pragma mark -
#pragma mark Configuration : Dynamic Enable

// Subclass if you need to dynamically enable/disable the service.  (For example if it only works with specific hardware)
+ (BOOL)canShare
{
	return YES;
}



#pragma mark -
#pragma mark Authentication

// These defines should be renamed (to match your service name).
// They will eventually be moved to SHKConfig so the user can modify them.

#define SHKYourServiceNameConsumerKey @""	// The consumer key
#define SHKYourServiceNameSecretKey @""		// The secret key
#define SHKYourServiceNameCallbackUrl @""	// The user defined callback url

- (id)init
{
	if (self = [super init])
	{		
		self.consumerKey = SHKYourServiceNameConsumerKey;		
		self.secretKey = SHKYourServiceNameSecretKey;
 		self.authorizeCallbackURL = [NSURL URLWithString:SHKYourServiceNameCallbackUrl];
		
		
		// -- //
		
		
		// Edit these to provide the correct urls for each oauth step
	    self.requestURL = [NSURL URLWithString:@"https://api.example.com/get_request_token"];
	    self.authorizeURL = [NSURL URLWithString:@"https://api.example.com/request_auth"];
	    self.accessURL = [NSURL URLWithString:@"https://api.example.com/get_token"];
		
		// Allows you to set a default signature type, uncomment only one
		//self.signatureProvider = [[[OAHMAC_SHA1SignatureProvider alloc] init] autorelease];
		//self.signatureProvider = [[[OAPlaintextSignatureProvider alloc] init] autorelease];
	}	
	return self;
}

// If you need to add additional headers or parameters to the request_token request, uncomment this section:
/*
- (void)tokenRequestModifyRequest:(OAMutableURLRequest *)oRequest
{
	// Here is an example that adds the user's callback to the request headers
	[oRequest setOAuthParameterName:@"oauth_callback" withValue:authorizeCallbackURL.absoluteString];
}
*/

// If you need to add additional headers or parameters to the access_token request, uncomment this section:
/*
- (void)tokenAccessModifyRequest:(OAMutableURLRequest *)oRequest
{
	// Here is an example that adds the oauth_verifier value received from the authorize call.
	// authorizeResponseQueryVars is a dictionary that contains the variables sent to the callback url
	[oRequest setOAuthParameterName:@"oauth_verifier" withValue:[authorizeResponseQueryVars objectForKey:@"oauth_verifier"]];
}
*/


#pragma mark -
#pragma mark Share Form

// If your action has options or additional information it needs to get from the user,
// use this to create the form that is presented to user upon sharing.
/*
- (NSArray *)shareFormFieldsForType:(SHKShareType)type
{
	// See http://getsharekit.com/docs/#forms for documentation on creating forms
	
	if (type == SHKShareTypeURL)
	{
		// An example form that has a single text field to let the user edit the share item's title
		return [NSArray arrayWithObjects:
				[SHKFormFieldSettings label:@"Title" key:@"title" type:SHKFormFieldTypeText start:item.title],
				nil];
	}
	
	else if (type == SHKShareTypeImage)
	{
		// return a form if required when sharing an image
		return nil;		
	}
	
	else if (type == SHKShareTypeText)
	{
		// return a form if required when sharing text
		return nil;		
	}
	
	else if (type == SHKShareTypeFile)
	{
		// return a form if required when sharing a file
		return nil;		
	}
	
	return nil;
}
*/

// If you have a share form the user will have the option to skip it in the future.
// If your form has required information and should never be skipped, uncomment this section.
/*
+ (BOOL)canAutoShare
{
	return NO;
}
*/

// Validate the user input on the share form
- (void)shareFormValidate:(SHKCustomFormController *)form
{	
	/*
	 
	 Services should subclass this if they need to validate any data before sending.
	 You can get a dictionary of the field values from [form formValues]
	 
	 --
	 
	 You should perform one of the following actions:
	 
	 1.	Save the form - If everything is correct call [form saveForm]
	 
	 2.	Display an error - If the user input was incorrect, display an error to the user and tell them what to do to fix it
	 
	 
	 */	
	
	// default does no checking and proceeds to share
	[form saveForm];
}



#pragma mark -
#pragma mark Implementation

// When an attempt is made to share the item, verify that it has everything it needs, otherwise display the share form
/*
- (BOOL)validateItem
{ 
	// The super class will verify that:
	// -if sharing a url	: item.url != nil
	// -if sharing an image : item.image != nil
	// -if sharing text		: item.text != nil
	// -if sharing a file	: item.data != nil
 
	return [super validateItem];
}
*/

// Send the share item to the server
- (BOOL)send
{	
	if (![self validateItem])
		return NO;
	
	/*
	 Enter the necessary logic to share the item here.
	 
	 The shared item and relevant data is in self.item
	 // See http://getsharekit.com/docs/#sending
	 
	 --
	 
	 A common implementation looks like:
	 	 
	 -  Send a request to the server
	 -  call [self sendDidStart] after you start your action
	 -	after the action completes, fails or is cancelled, call one of these on 'self':
		- (void)sendDidFinish (if successful)
		- (void)sendDidFailShouldRelogin (if failed because the user's current credentials are out of date)
		- (void)sendDidFailWithError:(NSError *)error shouldRelogin:(BOOL)shouldRelogin
		- (void)sendDidCancel
	 */ 
	
	
	// Here is an example.  
	// This example is for a service that can share a URL
	 
	/* 
	// Determine which type of share to do
	if (item.shareType == SHKShareTypeURL) // sharing a URL
	{
		// For more information on OAMutableURLRequest see http://code.google.com/p/oauthconsumer/wiki/UsingOAuthConsumer
		
		OAMutableURLRequest *oRequest = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.example.com/share"]
																		consumer:consumer // this is a consumer object already made available to us
																		   token:accessToken // this is our accessToken already made available to us
																		   realm:nil
															   signatureProvider:signatureProvider];
		
		// Set the http method (POST or GET)
		[oRequest setHTTPMethod:@"POST"];
		
		
		// Create our parameters
		OARequestParameter *urlParam = [[OARequestParameter alloc] initWithName:@"url"
																		  value:SHKEncodeURL(item.URL)];
		
		OARequestParameter *titleParam = [[OARequestParameter alloc] initWithName:@"title"
																		   value:SHKEncode(item.title)];
		
		// Add the params to the request
		[oRequest setParameters:[NSArray arrayWithObjects:titleParam, urlParam, nil]];
		[urlParam release];
		[titleParam release];
		
		// Start the request
		OAAsynchronousDataFetcher *fetcher = [OAAsynchronousDataFetcher asynchronousFetcherWithRequest:oRequest
																							  delegate:self
																					 didFinishSelector:@selector(sendTicket:didFinishWithData:)
																					   didFailSelector:@selector(sendTicket:didFailWithError:)];	
		
		[fetcher start];
		[oRequest release];
		
		// Notify delegate
		[self sendDidStart];
		
		return YES;
	}
	
	return NO;
	*/
}

// This is a continuation of the example provided in 'send' above.  It handles the OAAsynchronousDataFetcher response
// This is not a required method and is only provided as an example
/*
- (void)sendTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data 
{	
	if (ticket.didSucceed)
	{
		// The send was successful
		[self sendDidFinish];
	}
	
	else 
	{
		// Handle the error
		
		// If the error was the result of the user no longer being authenticated, you can reprompt
		// for the login information with:
		// [self sendDidFailShouldRelogin];
		
		// Otherwise, all other errors should end with:
		[self sendDidFailWithError:[SHK error:@"Why it failed"] shouldRelogin:NO];
	}
}
- (void)sendTicket:(OAServiceTicket *)ticket didFailWithError:(NSError*)error
{
	[self sendDidFailWithError:error shouldRelogin:NO];
}
*/

@end
