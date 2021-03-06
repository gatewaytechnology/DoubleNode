//
//  DNCommunicationDetails.m
//  Gateway Church and DoubleNode.com
//
//  Copyright (c) 2014 Gateway Church. All rights reserved.
//
//  Derived from work originally created by Darren Ehlers
//  Portions Copyright (c) 2012 DoubleNode.com and Darren Ehlers.
//  All rights reserved.
//

#import "DNCommunicationDetails.h"

#import "DNCommunicationPageDetails.h"

@implementation DNCommunicationDetails

+ (id)details
{
    return [[[self class] alloc] init];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.contentType    = DNCommunicationDetailsContentTypeFormUrlEncoded;
    }

    return self;
}

- (NSString*)path
{
    return self.router.path;
}

- (NSURL*)URL
{
    return self.router.URL;
}

- (NSString*)paramStringWithAllowedCharacterSet:(NSCharacterSet*)allowedCharacterSet
{
    NSMutableString*    paramString = [NSMutableString string];
    [self.parameters enumerateKeysAndObjectsUsingBlock:
     ^(NSString* key, id obj, BOOL* stop)
     {
         if ([obj isKindOfClass:[NSArray class]])
         {
             NSArray*   objArray    = obj;
             [objArray enumerateObjectsUsingBlock:
              ^(NSString* objStr, NSUInteger idx, BOOL* stop)
              {
                  [paramString appendFormat:@"%@[]=%@&", key, [self encodeObject:objStr withAllowedCharacterSet:allowedCharacterSet]];
              }];
         }
         else
         {
             [paramString appendFormat:@"%@=%@&", key, [self encodeObject:obj withAllowedCharacterSet:allowedCharacterSet]];
         }
     }];

    return paramString;
}

- (NSString*)encodeObject:(id)obj
  withAllowedCharacterSet:(NSCharacterSet*)allowedCharacterSet
{
    NSString*   retval = [NSString stringWithFormat:@"%@", obj];
    
    retval = [retval stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];

    return retval;
}

- (NSString*)fullPathOfPage:(DNCommunicationPageDetails*)pageDetails
{
    NSMutableCharacterSet*  allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:@"+&"];

    NSString*   encodedParamString  = [self paramStringWithAllowedCharacterSet:allowedCharacterSet];
    
    return [NSString stringWithFormat:@"%@?%@%@", self.path, encodedParamString, [pageDetails paramString]];
}

- (NSString*)pagingStringOfSize:(NSUInteger)pageSize
                        andPage:(NSUInteger)page
{
    return [NSString stringWithFormat:@"items_per_page=%lu&page=%lu", (unsigned long)pageSize, (unsigned long)page];
}

- (BOOL)enumeratePagesOfSize:(NSUInteger)pageSize
                  usingBlock:(BOOL (^)(DNCommunicationPageDetails* pageDetails, NSString* fullpath, BOOL* stop))block
{
    BOOL    retval = NO;

    NSUInteger  normalizedCount = (self.count == 0) ? 0 : (self.count - 1);
    NSUInteger  firstPage       = (self.offset / pageSize) + 1;
    NSUInteger  lastPage        = firstPage + ((normalizedCount + self.offset) / pageSize);
    for (NSUInteger page = firstPage; page <= lastPage; page++)
    {
        DNCommunicationPageDetails* pageDetails = [DNCommunicationPageDetails pageDetailsOfSize:pageSize andPage:page];

        NSString*   fullpath    = [self fullPathOfPage:pageDetails];

        BOOL    stop = NO;
        if (block(pageDetails, fullpath, &stop))
        {
            retval = YES;
        }

        if (stop)
        {
            break;
        }
    }

    return retval;
}

@end
