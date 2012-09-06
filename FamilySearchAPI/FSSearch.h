//
//  FSSearch.h
//  FamilySearchAPI
//
//  Created by Adam Kirk on 9/6/12.
//  Copyright (c) 2012 FamilySearch. All rights reserved.
//

#import <MTPocket.h>


typedef enum {
	FSSearchRelativeTypeSelf,
	FSSearchRelativeTypeMother,
	FSSearchRelativeTypeFather,
	FSSearchRelativeTypeSpouse
} FSSearchRelativeType;


// Person Properties
typedef NSString * FSSearchCriteria;
#define FSSearchCriteriaName				@"name"						// NSString
#define FSSearchCriteriaGivenName			@"givenName"				// NSString
#define FSSearchCriteriaFamilyName			@"familyName"				// NSString
#define FSSearchCriteriaGender				@"gender"					// NSString		@"Male" or @"Female"
#define FSSearchCriteriaBirthDate			@"birthDate"				// NSDate
#define FSSearchCriteriaBirthPlace			@"birthPlace"				// NSString
#define FSSearchCriteriaDeathDate			@"deathDate"				// NSDate
#define FSSearchCriteriaDeathPlace			@"deathPlace"				// NSString
#define FSSearchCriteriaMarriageDate		@"marriageDate"				// NSDate
#define FSSearchCriteriaMarriagePlace		@"marriagePlace"			// NSString


@class FSSearchResults;





@interface FSSearch : NSObject
@property (nonatomic) NSUInteger batchSize;
- (id)initWithSessionID:(NSString *)sessionID;
- (void)addValue:(id)value forCriteria:(FSSearchCriteria)criteria onRelative:(FSSearchRelativeType)relative matchingExactly:(BOOL)exact;
- (FSSearchResults *)results;
@end






@interface FSSearchResults : NSMutableArray
- (MTPocketResponse *)next;
@end




