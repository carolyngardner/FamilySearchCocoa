//
//  FSPersonTests.m
//  FamilySearchAPI
//
//  Created by Adam Kirk on 8/3/12.
//  Copyright (c) 2012 FamilySearch.org. All rights reserved.
//

#import "FSPersonTests.h"
#import "FSURL.h"
#import "FSAuth.h"
#import "FSPerson.h"
#import "constants.h"


@interface FSPersonTests ()
@property (strong, nonatomic) NSString *sessionID;
@property (strong, nonatomic) FSPerson *person;
@end


@implementation FSPersonTests

//- (void)setUp
//{
//	[FSURL setSandboxed:YES];
//
//	FSAuth *auth = [[FSAuth alloc] initWithDeveloperKey:SANDBOXED_DEV_KEY];
//	[auth loginWithUsername:SANDBOXED_USERNAME password:SANDBOXED_PASSWORD];
//	_sessionID = auth.sessionID;
//
//	_person = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	_person.name = @"Adam Kirk";
//	_person.gender = @"Male";
//	MTPocketResponse *response = [_person save];
//	STAssertTrue(response.success, nil);
//}
//
//- (void)testCurrentUserFetch
//{
//	MTPocketResponse *response = nil;
//
//	@try {
//		FSPerson *p = [FSPerson personWithSessionID:_sessionID identifier:nil];
//		[p fetch];
//		STFail(@"Was able to fetch person with nil identifier");
//	}
//	@catch (NSException *exception) {
//
//	}
//
//	FSPerson *me = [FSPerson currentUserWithSessionID:_sessionID];
//	FSPerson *me2 = [FSPerson currentUserWithSessionID:_sessionID];
//	STAssertTrue(me == me2, nil);
//
//	response = [me fetch];
//	response = [me2 fetch];
//	STAssertTrue(me == me2, nil);
//	STAssertTrue(response.success, nil);
//	STAssertNotNil(me.identifier, nil);
//	STAssertNotNil(me.name, nil);
//	STAssertNotNil(me.gender, nil);
//}
//
//- (void)testPersonFetch
//{
//	MTPocketResponse *response = [_person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertNotNil(_person.identifier, nil);
//	STAssertTrue([_person.name isEqualToString:@"Adam Kirk"], nil);
//	STAssertTrue([_person.gender isEqualToString:@"Male"], nil);
//}
//
//- (void)testFetchAncestors
//{
//	MTPocketResponse *response;
//
//	// create and add the father
//	FSPerson *father = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	father.name = @"Nathan Kirk";
//	father.gender = @"Male";
//
//	[_person addParent:father withLineage:FSLineageTypeBiological];
//	response = [_person save];
//	STAssertTrue(response.success, nil);
//	
//	response = [_person fetchAncestors:3];
//	STAssertTrue(response.success, nil);
//
//
//	NSUInteger ancestorCount = 0;
//	NSMutableArray *queue = [NSMutableArray arrayWithObject:_person];
//	while (queue.count > 0) {
//		ancestorCount++;
//		FSPerson *p = [queue objectAtIndex:0];
//		[queue removeObjectAtIndex:0];
//		for (FSPerson *parent in p.parents) {
//			[queue addObject:parent];
//		}
//	}
//	STAssertTrue(ancestorCount == 2, nil);
//}
//
////- (void)testCombineWithPerson
////{
////	MTPocketResponse *response;
////
////	FSPerson *p1 = [FSPerson personWithSessionID:_sessionID identifier:nil];
////	p1.name = @"Adam Taylor";
////	p1.gender = @"Male";
////	response = [p1 save];
////	STAssertTrue(response.success, nil);
////
////	NSString *previousID = [_person.identifier copy];
////	response = [_person combineWithPerson:p1];
////	STAssertTrue(response.success, nil);
////	STAssertFalse([_person.identifier isEqualToString:previousID], nil);
////}
//
//- (void)testbatchFetchPeople
//{
//	MTPocketResponse *response;
//
//	FSPerson *p1 = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	p1.name = @"Adam Taylor";
//	p1.gender = @"Male";
//	response = [p1 save];
//	STAssertTrue(response.success, nil);
//
//	FSPerson *p2 = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	p2.name = @"Adam Kirko";
//	p2.gender = @"Male";
//	response = [p2 save];
//	STAssertTrue(response.success, nil);
//
//	FSPerson *p3 = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	p3.name = @"Adumb Kirk";
//	p3.gender = @"Male";
//	response = [p3 save];
//	STAssertTrue(response.success, nil);
//
//	response = [FSPerson batchFetchPeople: @[ _person, p1, p2, p3 ] ];
//	STAssertTrue(response.success, nil);
//	STAssertNotNil(_person.name, nil);
//	STAssertNotNil(_person.gender, nil);
//	STAssertNotNil(p1.name, nil);
//	STAssertNotNil(p1.gender, nil);
//	STAssertNotNil(p2.name, nil);
//	STAssertNotNil(p2.gender, nil);
//	STAssertNotNil(p3.name, nil);
//	STAssertNotNil(p3.gender, nil);
//}
//
//- (void)testAddPropertiesToPerson
//{
//	MTPocketResponse *response;
//
//	// add the properties
//	[_person setProperty:@"Kirk" forKey:FSPropertyTypeCasteName];
//	[_person setProperty:@"Programmer" forKey:FSPropertyTypeOccupation];
//	response = [_person save];
//	STAssertTrue(response.success, nil);
//
//	// read and check the properties were added on the server
//	FSPerson *person = [FSPerson personWithSessionID:_sessionID identifier:_person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue([[person propertyForKey:FSPropertyTypeCasteName] isEqualToString:@"Kirk"], nil);
//	STAssertTrue([[person propertyForKey:FSPropertyTypeOccupation] isEqualToString:@"Programmer"], nil);
//}
//
//- (void)testAddAndRemoveFather
//{
//	MTPocketResponse *response;
//
//	// create and add the father
//	FSPerson *father = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	father.name = @"Nathan Kirk";
//	father.gender = @"Male";
//
//	[_person addParent:father withLineage:FSLineageTypeBiological];
//	response = [_person save];
//	STAssertTrue(response.success, nil);
//
//	// assert father was added
//	FSPerson *person = [FSPerson personWithSessionID:_sessionID identifier:_person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue(person.parents.count == 1, nil);
//
//	[person removeParent:father];
//	response = [person save];
//	STAssertTrue(response.success, nil);
//
//	// assert father was removed
//	person = [FSPerson personWithSessionID:_sessionID identifier:person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue(person.parents.count == 0, nil);
//}
//
//- (void)testAddAndRemoveMother
//{
//	MTPocketResponse *response;
//
//	// create and add the mother
//	FSPerson *mother = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	mother.name = @"Jackie Kirk";
//	mother.gender = @"Female";
//
//	[_person addParent:mother withLineage:FSLineageTypeBiological];
//	response = [_person save];
//	STAssertTrue(response.success, nil);
//
//	// assert mother was added
//	FSPerson *person = [FSPerson personWithSessionID:_sessionID identifier:_person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue(person.parents.count == 1, nil);
//
//	// remove the mother
//	[person removeParent:mother];
//	response = [person save];
//	STAssertTrue(response.success, nil);
//
//	// assert mother was removed
//	person = [FSPerson personWithSessionID:_sessionID identifier:person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue(person.parents.count == 0, nil);
//
//}
//
//- (void)testAddMotherAndFather
//{
//	MTPocketResponse *response;
//
//	// create and add the father
//	FSPerson *father = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	father.name = @"Nathan Kirk";
//	father.gender = @"Male";
//
//	// create and add the mother
//	FSPerson *mother = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	mother.name = @"Jackie Kirk";
//	mother.gender = @"Female";
//
//	[_person addParent:father withLineage:FSLineageTypeBiological];
//	[_person addParent:mother withLineage:FSLineageTypeBiological];
//	response = [_person save];
//	STAssertTrue(response.success, nil);
//
//	// read the father
//	FSPerson *person = [FSPerson personWithSessionID:_sessionID identifier:_person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue(person.parents.count == 2, nil);
//}
//
//- (void)testAddAndRemoveChild
//{
//	MTPocketResponse *response;
//
//	// create and add the child
//	FSPerson *child = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	child.name = @"Jack Kirk";
//	child.gender = @"Male";
//
//	[_person addChild:child withLineage:FSLineageTypeBiological];
//	response = [_person save];
//	STAssertTrue(response.success, nil);
//
//	// assert child was added
//	FSPerson *person = [FSPerson personWithSessionID:_sessionID identifier:_person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue(person.children.count == 1, nil);
//
//	// remove the child
//	[person removeChild:child];
//	response = [person save];
//	STAssertTrue(response.success, nil);
//
//	// assert child was removed
//	person = [FSPerson personWithSessionID:_sessionID identifier:person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue(person.children.count == 0, nil);
//}
//
//- (void)testAddAndRemoveSpouse
//{
//	MTPocketResponse *response;
//
//	// create and add the spouse
//	FSPerson *spouse = [FSPerson personWithSessionID:_sessionID identifier:nil];
//	spouse.name = @"She Kirk";
//	spouse.gender = @"Female";
//
//	[_person addSpouse:spouse];
//	response = [_person save];
//	STAssertTrue(response.success, nil);
//
//	// assert spouse was added
//	FSPerson *person = [FSPerson personWithSessionID:_sessionID identifier:_person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue(person.spouses.count == 1, nil);
//
//	// remove the spouse
//	[person removeSpouse:spouse];
//	response = [person save];
//	STAssertTrue(response.success, nil);
//
//	// assert spouse was removed
//	person = [FSPerson personWithSessionID:_sessionID identifier:person.identifier];
//	response = [person fetch];
//	STAssertTrue(response.success, nil);
//	STAssertTrue(person.spouses.count == 0, nil);
//}



@end
