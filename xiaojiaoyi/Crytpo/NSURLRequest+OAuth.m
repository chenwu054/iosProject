//
//  NSURLRequest+OAuth.m
//  YelpAPISample
//
//  Created by Thibaud Robelain on 7/2/14.
//  Copyright (c) 2014 Yelp Inc. All rights reserved.
//

#import "NSURLRequest+OAuth.h"
#import "OAMutableURLRequest.h"

/**
 OAuth credential placeholders that must be filled by each user in regards to
 http://www.yelp.com/developers/getting_started/api_access
 */
//#warning Fill in the API keys below with your developer v2 keys.
static NSString * const kConsumerKey       = @"f1UUkqY-ArXOelq_hGKBOg";
static NSString * const kConsumerSecret    = @"J-aIV0DJDUOJ4cBdGyBkIKmcdoY";
static NSString * const kToken             = @"-At-okxmS72TvU8_-y1iiO3wU57dzvVY";
static NSString * const kTokenSecret       = @"cb9FGc7X_WrsbEjihdqZ5y7Hz2Y";

@implementation NSURLRequest (OAuth)

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path {
  return [self requestWithHost:host path:path params:nil];
}

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params {
  NSURL *URL = [self _URLWithHost:host path:path queryParameters:params];

  if ([kConsumerKey length] == 0 || [kConsumerSecret length] == 0 || [kToken length] == 0 || [kTokenSecret length] == 0) {
    NSLog(@"WARNING: Please enter your api v2 credentials before attempting any API request. You can do so in NSURLRequest+OAuth.m");
  }

  OAConsumer *consumer = [[OAConsumer alloc] initWithKey:kConsumerKey secret:kConsumerSecret];
  OAToken *token = [[OAToken alloc] initWithKey:kToken secret:kTokenSecret];

  //The signature provider is HMAC-SHA1 by default and the nonce and timestamp are generated in the method
  OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:URL consumer:consumer token:token realm:nil signatureProvider:nil];
  [request setHTTPMethod:@"GET"];
  [request prepare]; // Attaches our consumer and token credentials to the request
   // NSDictionary* headers = [request allHTTPHeaderFields];
//    for(NSString * key in [headers allKeys]){
//        NSLog(@"key is %@ and value is %@",key, [headers valueForKey:key]);
//    }
   // NSLog(@"the url is %@",[request URL]);
  return request;
}

#pragma mark - URL Builder Helper

/**
 Builds an NSURL given a host, path and a number of queryParameters

 @param host The domain host of the API
 @param path The path of the API after the domain
 @param params The query parameters
 @return An NSURL built with the specified parameters
*/
+ (NSURL *)_URLWithHost:(NSString *)host path:(NSString *)path queryParameters:(NSDictionary *)queryParameters {

  NSMutableArray *queryParts = [[NSMutableArray alloc] init];
  for (NSString *key in [queryParameters allKeys]) {
    NSString *queryPart = [NSString stringWithFormat:@"%@=%@", key, queryParameters[key]];
      //NSLog(@"part is %@",queryPart);
    [queryParts addObject:queryPart];
  }
/*
 NSURLComponents to compose a URL request URL
 NSURLComponents will all the escaped characters into %xx chars such as space to %20
 */
  NSURLComponents *components = [[NSURLComponents alloc] init];
  components.scheme = @"http";
  components.host = host;
  components.path = path;
  components.query = [queryParts componentsJoinedByString:@"&"];
    
    NSURL * url =  [components URL];
   // NSLog(@"the url is:%@",url);
    
    return url;
}

@end
