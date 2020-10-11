//
//  HNFeed.h
//  HackerNewsKit
//
//  Created by Ryan Nystrom on 4/5/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

@import Foundation;

@class HNPost;

NS_ASSUME_NONNULL_BEGIN

@interface HNFeed : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong, readonly) NSArray<HNPost *> *items;
@property (nonatomic, strong, readonly) NSDate *createdDate;

- (instancetype)initWithItems:(nullable NSArray<HNPost *> *)items
                  createdDate:(nullable NSDate *)createdDate NS_DESIGNATED_INITIALIZER;

- (NSComparisonResult)compare:(HNFeed *)object;

- (instancetype)feedByMergingFeed:(HNFeed *)feed;
- (instancetype)feedByAppendingItems:(NSArray<HNPost *> *)items;

- (id)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
