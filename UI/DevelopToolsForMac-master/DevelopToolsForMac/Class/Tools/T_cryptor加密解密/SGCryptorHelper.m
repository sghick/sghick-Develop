//
//  SGCryptorHelper.m
//  DevelopToolsForMac
//
//  Created by buding on 15/8/13.
//  Copyright (c) 2015年 com.wp. All rights reserved.
//

#import "SGCryptorHelper.h"
#import "Cryptor.h"
#import "SGConfigManager.h"

@implementation SGCryptorHelper

- (void)execute:(id (^)())setup block:(void (^)(id))block {
    NSString * input = setup();
    if ([input isKindOfClass:[NSString class]]) {
        NSArray *inputs = [input componentsSeparatedByString:@":"];
        if (inputs.count != 2) {
            block(@"格式错误!\n\t格式是:\n\t\tkey:searl");
            return;
        }
        NSString *key = inputs[0];
        NSString *searl = inputs[1];
        NSString *edes = [SGCryptorHelper encodeDESwithKey:key searl:searl];
        NSLog(@"%@", edes);
        SGConfigManager * manager = [SGConfigManager defaultConfigManager];
        if (manager.curConfig.outputType.intValue == 1 && manager.curConfig.outputString && manager.curConfig.outputString.length) {
            [edes writeToFile:manager.curConfig.outputString atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        block(edes);
    }
}

+ (NSString *)encodeDESwithKey:(NSString *)key searl:(NSString *)searl {
    NSMutableString *rtn = [NSMutableString string];
    NSString *str = [Cryptor encodeDES:searl key:key];
    const char *chars = [str cStringUsingEncoding:NSUTF8StringEncoding];
    [rtn appendString:[NSString stringWithCString:chars encoding:NSUTF8StringEncoding]];
    [rtn appendString:@"\n"];
    for (int i = 0; i < strlen(chars); i++) {
        [rtn appendFormat:@"%d,\n", chars[i]];
    }
    return [rtn copy];
}

@end
