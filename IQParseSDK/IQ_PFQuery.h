//
//  IQ_PFQuery.h
//  IQParseSDK
//
//  Created by Mohd Iftekhar Qurashi on 08/09/13.
//  Copyright (c) 2013 Iftekhar. All rights reserved.
//

#import <Foundation/NSObject.h>
#import "IQ_PFConstants.h"

@class IQ_PFGeoPoint;

@interface IQ_PFQuery : NSObject

//+ (IQ_PFQuery *)queryWithClassName:(NSString *)className;
//+ (IQ_PFQuery *)queryWithClassName:(NSString *)className predicate:(NSPredicate *)predicate;
//
//- (instancetype)initWithClassName:(NSString *)newClassName;
//
//@property (nonatomic, strong) NSString *parseClassName;
//
//- (void)includeKey:(NSString *)key;
//- (void)selectKeys:(NSArray *)keys;
//- (void)whereKeyExists:(NSString *)key;
//- (void)whereKeyDoesNotExist:(NSString *)key;
//- (void)whereKey:(NSString *)key equalTo:(id)object;
//- (void)whereKey:(NSString *)key lessThan:(id)object;
//- (void)whereKey:(NSString *)key lessThanOrEqualTo:(id)object;
//- (void)whereKey:(NSString *)key greaterThan:(id)object;
//- (void)whereKey:(NSString *)key greaterThanOrEqualTo:(id)object;
//- (void)whereKey:(NSString *)key notEqualTo:(id)object;
//- (void)whereKey:(NSString *)key containedIn:(NSArray *)array;
//- (void)whereKey:(NSString *)key notContainedIn:(NSArray *)array;
//- (void)whereKey:(NSString *)key containsAllObjectsInArray:(NSArray *)array;
//- (void)whereKey:(NSString *)key nearGeoPoint:(IQ_PFGeoPoint *)geopoint;
//- (void)whereKey:(NSString *)key nearGeoPoint:(IQ_PFGeoPoint *)geopoint withinMiles:(double)maxDistance;
//- (void)whereKey:(NSString *)key nearGeoPoint:(IQ_PFGeoPoint *)geopoint withinKilometers:(double)maxDistance;
//- (void)whereKey:(NSString *)key nearGeoPoint:(IQ_PFGeoPoint *)geopoint withinRadians:(double)maxDistance;
//- (void)whereKey:(NSString *)key withinGeoBoxFromSouthwest:(IQ_PFGeoPoint *)southwest toNortheast:(IQ_PFGeoPoint *)northeast;
//- (void)whereKey:(NSString *)key matchesRegex:(NSString *)regex;
//- (void)whereKey:(NSString *)key matchesRegex:(NSString *)regex modifiers:(NSString *)modifiers;
//- (void)whereKey:(NSString *)key containsString:(NSString *)substring;
//- (void)whereKey:(NSString *)key hasPrefix:(NSString *)prefix;
//- (void)whereKey:(NSString *)key hasSuffix:(NSString *)suffix;
//+ (IQ_PFQuery *)orQueryWithSubqueries:(NSArray *)queries;
//- (void)whereKey:(NSString *)key matchesKey:(NSString *)otherKey inQuery:(IQ_PFQuery *)query;
//- (void)whereKey:(NSString *)key doesNotMatchKey:(NSString *)otherKey inQuery:(IQ_PFQuery *)query;
//- (void)whereKey:(NSString *)key matchesQuery:(IQ_PFQuery *)query;
//- (void)whereKey:(NSString *)key doesNotMatchQuery:(IQ_PFQuery *)query;
//
//- (void)orderByAscending:(NSString *)key;
//- (void)addAscendingOrder:(NSString *)key;
//- (void)orderByDescending:(NSString *)key;
//- (void)addDescendingOrder:(NSString *)key;
//- (void)orderBySortDescriptor:(NSSortDescriptor *)sortDescriptor;
//
//+ (IQ_PFObject *)getObjectOfClass:(NSString *)objectClass objectId:(NSString *)objectId;
//+ (IQ_PFObject *)getObjectOfClass:(NSString *)objectClass objectId:(NSString *)objectId error:(NSError **)error;
//- (IQ_PFObject *)getObjectWithId:(NSString *)objectId;
//- (IQ_PFObject *)getObjectWithId:(NSString *)objectId error:(NSError **)error;
//- (void)getObjectInBackgroundWithId:(NSString *)objectId block:(IQ_PFObjectResultBlock)block;
//- (void)getObjectInBackgroundWithId:(NSString *)objectId target:(id)target selector:(SEL)selector;
//+ (IQ_PFUser *)getUserObjectWithId:(NSString *)objectId;
//+ (IQ_PFUser *)getUserObjectWithId:(NSString *)objectId error:(NSError **)error;
//
//- (NSArray *)findObjects;
//- (NSArray *)findObjects:(NSError **)error;
//- (void)findObjectsInBackgroundWithBlock:(IQ_PFArrayResultBlock)block;
//- (void)findObjectsInBackgroundWithTarget:(id)target selector:(SEL)selector;
//- (IQ_PFObject *)getFirstObject;
//- (IQ_PFObject *)getFirstObject:(NSError **)error;
//- (void)getFirstObjectInBackgroundWithBlock:(IQ_PFObjectResultBlock)block;
//- (void)getFirstObjectInBackgroundWithTarget:(id)target selector:(SEL)selector;

//- (NSInteger)countObjects;
//- (NSInteger)countObjects:(NSError **)error;
//- (void)countObjectsInBackgroundWithBlock:(IQ_PFIntegerResultBlock)block;
//- (void)countObjectsInBackgroundWithTarget:(id)target selector:(SEL)selector;

//- (void)cancel;

//@property (nonatomic, assign) NSInteger limit;
//@property (nonatomic, assign) NSInteger skip;

//@property (assign, readwrite) IQ_PFCachePolicy cachePolicy;
//@property (assign, readwrite) NSTimeInterval maxCacheAge;

//- (BOOL)hasCachedResult;
//- (void)clearCachedResult;
//+ (void)clearAllCachedResults;

//@property (nonatomic, assign) BOOL trace;

@end
