FamilySearchCocoa
===============

An easy to use library for interacting with the FamilySearch.org API on iOS or OS X.

### Installation

In your Podfile, add this line:

	pod "FamilySearchCocoa"

pod? => https://github.com/CocoaPods/CocoaPods/

### Overview

`FSPerson` is the center of the object graph. Make all your changes to an `FSPerson` and then call save on that person.

Make a bunch of modifications to properties, relationships, etc and then call `save` on a person and it will commit all of it to the server.

`fetch` does the same in reverse. It will fetch all properties and relationships from the server all at once.

See the header files for the full API and more documentation.

### Notes

- Any method that returns an `MTPocketResponse` object is blocking and needs to be called on a background thread.
- By adding relationships, events, etc, you create an object graph of people and events. You can call `save` on any person in the object graph to save the whole thing.

### Usage

Use FSUser to log in and get a session id:

	FSUser *user = [[FSUser alloc] initWithDeveloperKey:SANDBOXED_DEV_KEY];
	MTPocketResponse *response = [user loginWithUsername:SANDBOXED_USERNAME password:SANDBOXED_PASSWORD];
	
	if (response.success) {
		_sessionID = user.sessionID;;
	}

If you want to use the sandbox environment:

	[FSURL setSandboxed:YES];

Get information about yourself:

	FSPerson *me = [FSPerson currentUserWithSessionID:_sessionID];
	MTPocketResponse *response = [me fetch];
	if (response.success) {
		me.name 											// => @"Adam Kirk"
		me.isAlive											// => YES
		me.gender 											// => @"Male"
		me.parents.count									// => 2
		[me characteristicForKey:FSPropertyTypeOccupation];	// => @"Saint"
	}

Get information about someone else:

	FSPerson *you = [FSPerson personWithSessionID:_sessionID identifier:@"BLAH-BLAH"];
	MTPocketResponse *response = [you fetch];
	if (response.success) {
		you.name 				// => @"Gamima Smitty"
		you.gender 				// => @"Female"
		you.parents.count		// => 1
	}

Create a person:

	person = [FSPerson personWithSessionID:_sessionID identifier:nil];
	person.name = @"Adam Kirk";
	person.gender = @"Male";
	MTPocketResponse *response = [person save];

Update a person:

	person = [FSPerson personWithSessionID:_sessionID identifier:@"BLAH-BLAH"];
	[person setCharacteristic:@"Programmer" forKey:FSPropertyTypeOccupation];
	[person save];

Add/Remove a parent:

	person.parents.count	// => 0
	
	FSPerson *father = [FSPerson personWithSessionID:_sessionID identifier:nil];
	father.name = @"Nathan Kirk";
	father.gender = @"Male";
	
	[person addParent:father withLineage:FSLineageTypeBiological];
	[person save];
	
	person.parents.count	// => 1
	
	[person removeParent:father];
	[person save];
	
	person.parents.count	// => 0

Add/Remove a child:

	person.children.count	// => 0
	
	FSPerson *child = [FSPerson personWithSessionID:_sessionID identifier:nil];
	child.name = @"Jim Kirk";
	child.gender = @"Male";
	
	[person addChild:child withLineage:FSLineageTypeAdoptive];
	[person save];
	
	person.children.count	// => 1
	
	[person removeChild:child];
	[person save];
	
	person.children.count	// => 0

Add/Remove an Event:

	person.events.count		// => 0
	
	FSEvent *death = [FSEvent eventWithType:FSPersonEventTypeDeath identifier:nil];
	death.date = [NSDateComponents componentsFromString:@"11 August 1995"];
	death.place = @"Kennewick, WA";
	[person addEvent:death];
	
	FSEvent *event = [FSEvent eventWithType:FSPersonEventTypeBaptism identifier:nil];
	event.date = [NSDateComponents componentsFromString:@"11 August 1994"];
	event.place = @"Kennewick, WA";
	[person addEvent:event];
	[person save];
	
	person.events.count		// => 2
	
	[person removeEvent:event];
	[person save];
	
	person.events.count		// => 1	

Convenience Events:
	
	person.birthDate	= [NSDateComponents componentsFromString:@"11 August 1995"];
	person.birthPlace	= @"Kennewick, Benton, Washington, United States";
	person.deathDate	= [NSDateComponents componentsFromString:@"11 August 1996"];
	person.deathPlace	= @"Pasco, Franklin, Washington, United States";
	[person save];

Add/Remove a marriage

	person.marriages.count 	// => 0
	
	FSPerson *spouse = [FSPerson personWithSessionID:_sessionID identifier:nil];
	spouse.name = @"She Kirk";
	spouse.gender = @"Female";
	
	FSMarriage *marriage = [FSMarriage marriageWithHusband:person wife:spouse];
	[person addMarriage:marriage];
	[person save];
	
	person.marriages.count	// => 1
		
	[person removeMarriage:marriage];
	[person save];
	
	person.marriages.count	// => 0

Add/Read Marriage Properties:

	FSPerson *spouse = [FSPerson personWithSessionID:_sessionID identifier:nil];
	spouse.name = @"She Man";
	spouse.gender = @"Female";
	
	FSMarriage *marriage = [FSMarriage marriageWithHusband:person wife:spouse];
	[person addMarriage:marriage];
	[person save];
	
	person.marriages.count	// => 1
	
	[marriage setProperty:@"2" forKey:FSMarriagePropertyTypeNumberOfChildren];
	[marriage setProperty:@"True" forKey:FSMarriagePropertyTypeCommonLawMarriage];
	[marriage save];
	
	FSPerson *p = [FSPerson personWithSessionID:_sessionID identifier:person.identifier];
	[p fetch];
	FSMarriage *m = [p marriageWithSpouse:spouse];
	[m propertyForKey:FSMarriagePropertyTypeNumberOfChildren]	// => @"2"
	[m propertyForKey:FSMarriagePropertyTypeCommonLawMarriage]	// => @"True"

Add/Remove a Marriage Event:

	person.spouses.count	// => 0
	
	FSPerson *spouse = [FSPerson personWithSessionID:_sessionID identifier:nil];
	spouse.name = @"She Man";
	spouse.gender = @"Female";
	
	FSMarriage *marriage = [FSMarriage marriageWithHusband:person wife:spouse];
	[person addMarriage:marriage];
	[person save];
	
	person.marriages.count	// => 1
	
	marriage.events.count	// => 0
	
	FSMarriageEvent *event = [FSMarriageEvent marriageEventWithType:FSMarriageEventTypeMarriage identifier:nil];
	event.date = [NSDateComponents componentsFromString:@"11 August 1995"];
	event.place = @"Kennewick, WA";
	[marriage addMarriageEvent:event];
	[marriage save];
	
	marriage.events.count	// => 1
	
	[marriage removeMarriageEvent:event];
	[marriage save];
	
	person = [FSPerson personWithSessionID:_sessionID identifier:person.identifier];
	[person fetch];
	FSMarriage *m = [person marriageWithSpouse:spouse];
	
	m.events.count			// => 0

### Ordinances

The flow to move a user from adding an ancestor to their family tree to doing their temple work is as simple as:

	// create a person
	FSPerson *person = [FSPerson personWithSessionID:_sessionID identifier:nil];
	
	// add minimum info to qualify them for reservation
	person.name			= @"Nathan Kirk";
	person.gender		= @"Male";
	person.deathDate	= [NSDateComponents componentsFromString:@"11 August 1970"];
	person.deathPlace	= @"Pasco, Franklin, Washington, United States";
	[person save];
	
	// reserve the person, claiming you want to do their ordinances
	[FSOrdinance reserveOrdinancesForPeople:@[person] inventory:FSOrdinanceInventoryTypePersonal];
	
	// generate a family ordinace request and return the URL to it.
	NSURL *url = [FSOrdinance familyOrdinanceRequestPDFURLForPeople:people response:&response];

Once the url to the Family Ordinance Request PDF is obtained, your application can download the PDF and let the user view/print it.

### Artifacts

You can add and read media attached to people in the read (e.g. photos, audio, etc).

	// create and upload an artifact
	UIImage *image = [UIImage imageNamed:@"jimmy"];
	FSArtifact *artifact = [FSArtifact artifactWithData:UIImagePNGRepresentation(image) MIMEType:FSArtifactMIMETypeImagePNG sessionID:_sessionID];
	MTPocketResponse *response = [artifact save];
	
	// tag a person in the artifact
	FSArtifactTag *tag = [FSArtifactTag tagWithPerson:_person title:@"Don Kirk" rect:CGRectMake(0, 0, 60, 88)];
	[artifact addTag:tag];
	response = [artifact save];
	
	// remove a tag
	[artifact removeTag:tag]
	response = [artifact save];
	
	// fetch all the artifacts a person is tagged in
	NSArray *artifacts = [FSArtifact artifactsForPerson:_person category:FSArtifactCategoryImage response:&response];
    
	// delete an artifact
	response = [artifact destroy];

### Testing

To run the unit tests, you need to create the missing "constants.h" file with the following contents:

	#define SANDBOXED_DEV_KEY	@"<sandboxed dev key>"
	#define SANDBOXED_USERNAME	@"<sandboxed username>"
	#define SANDBOXED_PASSWORD	@"<sandboxed password>"

	#define PRODUCTION_DEV_KEY	@"<live dev key>"
	#define PRODUCTION_USERNAME	@"<live username>"
	#define PRODUCTION_PASSWORD	@"<live password>"
	#define PRODUCTION_PERSON_ID    @"<a real id from a person in the production tree>"