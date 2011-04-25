//
//  «FILENAME»
//  «PROJECTNAME»
//
//  Created by «FULLUSERNAME» on «DATE».
//  Copyright «YEAR» «ORGANIZATIONNAME». All rights reserved.
//

«OPTIONALHEADERIMPORTLINE»

@implementation «FILEBASENAMEASIDENTIFIER»


#pragma mark -
#pragma mark Configuration : Service Defination

// Enter the name of the action
+ (NSString *)sharerTitle
{
	return @"Name of Action";
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


// Does the action require an internet connection to work?
+ (BOOL)shareRequiresInternetConnection
{
	return NO;
}

// This should always be NO because actions do not connect to a web service.  If you want to connect
// to a web service, use the Web Service templates.
+ (BOOL)requiresAuthentication
{
	return NO;
}


#pragma mark -
#pragma mark Configuration : Dynamic Enable

// Subclass if you need to dynamically enable/disable the action.  (For example if it only works with specific hardware)
+ (BOOL)canShare
{
	return YES;
}



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
- (BOOL)canAutoShare
{
	return NO;
}
*/



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
 
	// You only need to implement this if you need to check additional variables.
 
	return [super validateItem];
}
*/

// Performs the action
- (BOOL)send
{	
	// Make sure that the item has minimum requirements
	if (![self validateItem])
		return NO;
	
	// Implement your action here
	
	// If the action is asynchronous and will not be completed by the time send returns
	// call [self sendDidStart] after you start your action
	// then after the action completes, fails or is cancelled, call one of these on 'self':
	// - (void)sendDidFinish (if successful)
	// - (void)sendDidFailShouldRelogin (if failed because the user's current credentials are out of date)
	// - (void)sendDidFailWithError:(NSError *)error shouldRelogin:(BOOL)shouldRelogin
	// - (void)sendDidCancel
	
	return YES; // return YES if the action has started or completed
}


@end
