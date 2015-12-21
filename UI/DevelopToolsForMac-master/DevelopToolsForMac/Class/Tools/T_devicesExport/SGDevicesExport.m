//
//  SGDevicesExport.m
//  DevelopToolsForMac
//
//  Created by buding on 15/11/5.
//  Copyright © 2015年 com.wp. All rights reserved.
//

#import "SGDevicesExport.h"

@implementation SGDevicesExport

- (void)execute:(id (^)())setup block:(void (^)(id))block {
    NSString * input = setup();
    if ([input isKindOfClass:[NSString class]]) {
        NSString *head = @"ui-jqgrid ui-widget ui-widget-content ui-corner-all";
        NSString *end = @"content-bottom";
        NSRange bodyHeadRange = [input rangeOfString:head];
        NSRange bodyEndRange = [input rangeOfString:end];
        NSString *body = [input substringWithRange:NSMakeRange(bodyHeadRange.location, bodyEndRange.location - bodyHeadRange.location)];
        NSString *dName = @"grid-table_name";
        NSString *dNumber = @"grid-table_deviceNumber";
        NSString *space = @"	";
        NSMutableString *rtn = [NSMutableString string];
        NSArray *inputs = [body componentsSeparatedByString:@"</tr>"];
        for (NSString *tr in inputs) {
            if ([tr containsString:dName] && [tr containsString:dNumber]) {
                NSArray *tds = [tr componentsSeparatedByString:@"</td>"];
                NSString *name = nil;
                NSString *number = nil;
                for (NSString *td in tds) {
                    NSRange nameRange = [td rangeOfString:dName];
                    NSRange numberRange = [td rangeOfString:dNumber];
                    if ((nameRange.location > 0) && (nameRange.location != NSNotFound)) {
                        name = [td substringFromIndex:nameRange.location + nameRange.length + 2];
                    }
                    if ((numberRange.location > 0) && (numberRange.location != NSNotFound)) {
                        number = [td substringFromIndex:numberRange.location + numberRange.length + 2];
                    }
                    if (name && number) {
                        break;
                    }
                }
                if (name && number) {
                    if (rtn.length > 0) {
                        [rtn appendFormat:@"%@%@%@\n", number, space, name];
                    } else {
                        [rtn appendFormat:@"Device ID	Device Name\n"];
                    }
                }
            }
        }
        block([rtn copy]);
    }
}

@end
