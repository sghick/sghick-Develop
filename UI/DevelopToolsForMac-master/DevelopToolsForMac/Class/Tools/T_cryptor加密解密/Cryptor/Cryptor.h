//
//  Cryptor.h
//  test
//
//  Created by Da Zhang on 11/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@interface Cryptor : NSObject {
    
}

/*
 all the methods below only support utf8 string
 */
+ (NSString *)encodeMD5:(NSString *)str;

+ (NSString *)encodeDES:(NSString *)plainString key:(NSString *)key;
+ (NSString *)decodeDES:(NSString *)decodedString key:(NSString*)key;

+ (NSString *)encodeBase64:(NSString *)plainString;
+ (NSString *)decodeBase64:(NSString *)decodedString;

@end
