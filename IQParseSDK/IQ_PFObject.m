//
//  IQ_PFObject.m
//  IQParseSDK
//
//  Created by lucho on 8/28/13.
//  Copyright (c) 2013 lucho. All rights reserved.
//

#import "IQ_PFObject.h"
#import "IQ_PFWebService.h"

#import <Foundation/NSDate.h>
#import <Foundation/NSThread.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSDateFormatter.h>
#import <Foundation/NSTimeZone.h>

@interface IQ_PFObject()

@end

@implementation IQ_PFObject
{
    NSMutableDictionary *displayAttributes;
    
    NSMutableDictionary *needUpdateAttributes;
}

//@synthesize parseClassName = _parseClassName, objectId = _objectId, updatedAt = _updatedAt, createdAt = _createdAt;


- (id)init
{
    self = [super init];
    if (self)
    {
        displayAttributes       = [[NSMutableDictionary alloc] init];
        needUpdateAttributes    = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (IQ_PFObject *)objectWithClassName:(NSString *)className
{
    return [[self alloc] initWithClassName:className dictionary:nil];
}

+ (instancetype)objectWithoutDataWithClassName:(NSString *)className objectId:(NSString *)objectId
{
    IQ_PFObject *object = [[self alloc] initWithClassName:className];
    object.objectId = objectId;
    return object;
}

+ (instancetype)objectWithClassName:(NSString *)className dictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithClassName:className dictionary:dictionary];
}

- (instancetype)initWithClassName:(NSString *)newClassName
{
    self = [self init];
    
    if (self)
    {
        _parseClassName = newClassName;
    }
    
    return self;
}

- (instancetype)initWithClassName:(NSString *)newClassName dictionary:(NSDictionary *)dictionary
{
    self = [self initWithClassName:newClassName];
    
    if (self)
    {
        [displayAttributes      addEntriesFromDictionary:dictionary];
        [needUpdateAttributes   addEntriesFromDictionary:dictionary];
    }
    
    return self;
}

- (NSArray *)allKeys
{
    return [displayAttributes allKeys];
}

- (id)objectForKey:(NSString *)key
{
    return [displayAttributes objectForKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key
{
    if (object != nil)
    {
        [displayAttributes      setObject:object forKey:key];
        [needUpdateAttributes   setObject:object forKey:key];
    }
    else
    {
        [self removeObjectForKey:key];
    }
}

- (void)removeObjectForKey:(NSString *)key
{
    [displayAttributes      removeObjectForKey:key];
    [needUpdateAttributes   removeObjectForKey:key];
}

//- (IQ_PFRelation *)relationForKey:(NSString *)key;

- (void)addObject:(id)object forKey:(NSString *)key
{
    //Update display attributes
    {
        NSArray *displayArray = [displayAttributes objectForKey:key];
        if (displayArray == nil)    displayArray = [[NSArray alloc] init];
        [displayAttributes setObject:[displayArray arrayByAddingObject:object] forKey:key];
    }

    id value = [needUpdateAttributes objectForKey:key];
    if (value == nil)
    {
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:@[object]] forKey:key];
    }
    else if ([value isKindOfClass:[NSArray class]])
    {
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:@[object]] forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSDictionary *dict = [value objectForKey:kParse__OpKey];
        
        NSArray *newAttributedArray = [[dict objectForKey:kParseObjectsKey] arrayByAddingObject:object];
        
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:newAttributedArray] forKey:key];
    }
}

- (void)addObjectsFromArray:(NSArray *)objects forKey:(NSString *)key
{
    //Update display attributes
    {
        NSArray *displayArray = [displayAttributes objectForKey:key];
        if (displayArray == nil)    displayArray = [[NSArray alloc] init];
        [displayAttributes setObject:[displayArray arrayByAddingObjectsFromArray:objects] forKey:key];
    }

    id value = [needUpdateAttributes objectForKey:key];
    if (value == nil)
    {
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:objects] forKey:key];
    }
    else if ([value isKindOfClass:[NSArray class]])
    {
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:objects] forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSDictionary *dict = [value objectForKey:kParse__OpKey];
        
        NSArray *newAttributedArray = [[dict objectForKey:kParseObjectsKey] arrayByAddingObjectsFromArray:objects];
        
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:newAttributedArray] forKey:key];
    }
}

- (void)addUniqueObject:(id)object forKey:(NSString *)key
{
    //Update display attributes
    {
        NSArray *displayArray = [displayAttributes objectForKey:key];
        if (displayArray == nil)    displayArray = [[NSArray alloc] init];
        if ([displayArray containsObject:object] == NO)
        {
            [displayAttributes setObject:[displayArray arrayByAddingObject:object] forKey:key];
        }
    }

    id value = [needUpdateAttributes objectForKey:key];
    if (value == nil)
    {
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:@[object]] forKey:key];
    }
    else if ([value isKindOfClass:[NSArray class]])
    {
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:@[object]] forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSDictionary *dict = [value objectForKey:kParse__OpKey];
        
        NSArray *attributedArray = [dict objectForKey:kParseObjectsKey];
        
        if ([attributedArray containsObject:object] == NO)
        {
            [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:[attributedArray arrayByAddingObject:object]] forKey:key];
        }
    }
}

- (void)addUniqueObjectsFromArray:(NSArray *)objects forKey:(NSString *)key
{
    //Update display attributes
    {
        NSArray *displayArray = [displayAttributes objectForKey:key];

        NSMutableOrderedSet *orderedDisplaySet = [[NSMutableOrderedSet alloc] initWithArray:displayArray];
        [orderedDisplaySet addObjectsFromArray:objects];
        [displayAttributes setObject:[orderedDisplaySet array] forKey:key];
    }

    id value = [needUpdateAttributes objectForKey:key];
    if (value == nil)
    {
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:objects] forKey:key];
    }
    else if ([value isKindOfClass:[NSArray class]])
    {
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:objects] forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSDictionary *dict = [value objectForKey:kParse__OpKey];
        NSMutableOrderedSet *orderedAttributedSet = [[NSMutableOrderedSet alloc] initWithArray:[dict objectForKey:kParseObjectsKey]];
        [orderedAttributedSet addObjectsFromArray:objects];
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:[orderedAttributedSet array]] forKey:key];
    }
}

- (void)removeObject:(id)object forKey:(NSString *)key
{
    //Update display attributes
    {
        NSMutableArray *newArray = [[displayAttributes objectForKey:key] mutableCopy];
        [newArray removeObject:object];
        [displayAttributes setObject:newArray forKey:key];
    }

    id value = [needUpdateAttributes objectForKey:key];
    
    if ([value isKindOfClass:[NSArray class]])
    {
        NSMutableArray *newArray = [value mutableCopy];
        [newArray removeObject:object];
        [needUpdateAttributes setObject:newArray forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSMutableDictionary *dict = [[value objectForKey:kParse__OpKey] mutableCopy];
        
        NSMutableArray *newAttributedArray = [[dict objectForKey:kParseObjectsKey] mutableCopy];
        [newAttributedArray removeObject:object];
        
        if ([newAttributedArray count])
        {
            [dict setObject:newAttributedArray forKey:kParseObjectsKey];
            [needUpdateAttributes setObject:dict forKey:key];
        }
        else
        {
            [needUpdateAttributes removeObjectForKey:key];
        }
    }
}

- (void)removeObjectsInArray:(NSArray *)objects forKey:(NSString *)key
{
    //Update display attributes
    {
        NSMutableArray *newArray = [[displayAttributes objectForKey:key] mutableCopy];
        [newArray removeObjectsInArray:objects];
        [displayAttributes setObject:newArray forKey:key];
    }
    
    id value = [needUpdateAttributes objectForKey:key];
    
    if ([value isKindOfClass:[NSArray class]])
    {
        NSMutableArray *newArray = [value mutableCopy];
        [newArray removeObjectsInArray:objects];
        [needUpdateAttributes setObject:newArray forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSMutableDictionary *dict = [[value objectForKey:kParse__OpKey] mutableCopy];
        
        NSMutableArray *newAttributedArray = [[dict objectForKey:kParseObjectsKey] mutableCopy];
        [newAttributedArray removeObjectsInArray:objects];
        
        if ([newAttributedArray count])
        {
            [dict setObject:newAttributedArray forKey:kParseObjectsKey];
            [needUpdateAttributes setObject:dict forKey:key];
        }
        else
        {
            [needUpdateAttributes removeObjectForKey:key];
        }
    }
}

- (void)incrementKey:(NSString *)key
{
    [displayAttributes setObject:[[self class] incrementAttribute] forKey:key];
}

- (void)incrementKey:(NSString *)key byAmount:(NSNumber *)amount
{
    [displayAttributes setObject:[[self class] incrementAttributeByAmount:amount] forKey:key];
}

//- (BOOL)save;
//- (BOOL)save:(NSError **)error;
- (void)saveInBackground
{
    [self saveInBackgroundWithBlock:NULL];
}

- (void)saveInBackgroundWithBlock:(IQ_PFBooleanResultBlock)block
{
    if (self.objectId)
    {
        [[IQ_PFWebService service] updateObjectWithParseClass:self.parseClassName objectId:self.objectId attributes:needUpdateAttributes completionHandler:^(NSDictionary *result, NSError *error) {
            if (result)
            {
                if ([result objectForKey:kParseCreatedAtKey])
                    _createdAt  =   [[[self class] formatter] dateFromString:[result objectForKey:kParseCreatedAtKey]];
                
                if ([result objectForKey:kParseUpdatedAtKey])
                    _updatedAt  =   [[[self class] formatter] dateFromString:[result objectForKey:kParseUpdatedAtKey]];
                
                _objectId   =   [result objectForKey:kParseObjectIdKey];
            }

            if (block)
            {
                block((result!= nil),error);
            }
        }];
    }
    else
    {
        [[IQ_PFWebService service] createObjectWithParseClass:self.parseClassName attributes:needUpdateAttributes completionHandler:^(NSDictionary *result, NSError *error) {
            if (result)
            {
                if ([result objectForKey:kParseCreatedAtKey])
                    _createdAt  =   [[[self class] formatter] dateFromString:[result objectForKey:kParseCreatedAtKey]];

                if ([result objectForKey:kParseUpdatedAtKey])
                    _updatedAt  =   [[[self class] formatter] dateFromString:[result objectForKey:kParseUpdatedAtKey]];

                _objectId   =   [result objectForKey:kParseObjectIdKey];
            }
            
            if (block)
            {
                block((result!= nil),error);
            }
        }];
    }
}

- (void)saveInBackgroundWithTarget:(id)target selector:(SEL)selector
{
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        [invocation setArgument:&(succeeded) atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];

    }];
}


//- (void)saveEventually;
//- (void)saveEventually:(IQ_PFBooleanResultBlock)callback;

//+ (BOOL)saveAll:(NSArray *)objects;
//+ (BOOL)saveAll:(NSArray *)objects error:(NSError **)error;
//+ (void)saveAllInBackground:(NSArray *)objects;
//+ (void)saveAllInBackground:(NSArray *)objects block:(IQ_PFBooleanResultBlock)block;
//+ (void)saveAllInBackground:(NSArray *)objects target:(id)target selector:(SEL)selector;

//+ (BOOL)deleteAll:(NSArray *)objects;
//+ (BOOL)deleteAll:(NSArray *)objects error:(NSError **)error;
//+ (void)deleteAllInBackground:(NSArray *)objects;
//+ (void)deleteAllInBackground:(NSArray *)objects block:(IQ_PFBooleanResultBlock)block;
//+ (void)deleteAllInBackground:(NSArray *)objects target:(id)target selector:(SEL)selector;

//- (BOOL)isDataAvailable;
//- (void)refresh;
//- (void)refresh:(NSError **)error;
//- (void)refreshInBackgroundWithBlock:(IQ_PFObjectResultBlock)block;
//- (void)refreshInBackgroundWithTarget:(id)target selector:(SEL)selector;

//- (void)fetch:(NSError **)error;
//- (IQ_PFObject *)fetchIfNeeded;
//- (IQ_PFObject *)fetchIfNeeded:(NSError **)error;
//- (void)fetchInBackgroundWithBlock:(IQ_PFObjectResultBlock)block;
//- (void)fetchInBackgroundWithTarget:(id)target selector:(SEL)selector;
//- (void)fetchIfNeededInBackgroundWithBlock:(IQ_PFObjectResultBlock)block;
//- (void)fetchIfNeededInBackgroundWithTarget:(id)target selector:(SEL)selector;

//+ (void)fetchAll:(NSArray *)objects;
//+ (void)fetchAll:(NSArray *)objects error:(NSError **)error;
//+ (void)fetchAllIfNeeded:(NSArray *)objects;
//+ (void)fetchAllIfNeeded:(NSArray *)objects error:(NSError **)error;
//+ (void)fetchAllInBackground:(NSArray *)objects block:(IQ_PFArrayResultBlock)block;
//+ (void)fetchAllInBackground:(NSArray *)objects target:(id)target selector:(SEL)selector;
//+ (void)fetchAllIfNeededInBackground:(NSArray *)objects block:(IQ_PFArrayResultBlock)block;
//+ (void)fetchAllIfNeededInBackground:(NSArray *)objects target:(id)target selector:(SEL)selector;

//- (BOOL)delete;
//- (BOOL)delete:(NSError **)error;
//- (void)deleteInBackground;
//- (void)deleteInBackgroundWithBlock:(IQ_PFBooleanResultBlock)block;
//- (void)deleteInBackgroundWithTarget:(id)target selector:(SEL)selector;
//- (void)deleteEventually;

//- (BOOL)isDirty;
//- (BOOL)isDirtyForKey:(NSString *)key;





+ (NSDateFormatter *)formatter
{
	NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
	NSDateFormatter *formatter = dictionary[@"iso"];
	if (!formatter)
    {
		formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
		formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
		dictionary[@"iso"] = formatter;
	}
	return formatter;
}


//Private methods

//Increment/Decrement Number Attribute
+(NSDictionary *)incrementAttribute
{
    return [self incrementAttributeByAmount:@1];
}

+(NSDictionary *)incrementAttributeByAmount:(NSNumber*)amount
{
    return @{kParse__OpKey:@"Increment",@"amount":amount};
}

+(NSDictionary*)addAttributeWithArray:(NSArray*)array
{
    return @{kParse__OpKey:@"Add",      kParseObjectsKey:array};
}

+(NSDictionary*)addUniqueAttributeWithArray:(NSArray*)array
{
    return @{kParse__OpKey:@"AddUnique",kParseObjectsKey:array};
}

+(NSDictionary*)removeAttributeWithArray:(NSArray*)array
{
    return @{kParse__OpKey:@"Remove",   kParseObjectsKey:array};
}

@end
