//
//  HNPostControllerHandling.m
//  HackerNewsReader
//
//  Created by Ryan Nystrom on 6/1/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

#import <SafariServices/SafariServices.h>

#import "HNPostControllerHandling.h"

#import "HNPost.h"

#import "HNCommentViewController.h"
#import "NSURL+HackerNews.h"

#import "UIColor+HackerNews.h"

void hn_enableAppearance(SFSafariViewController *safariVC) {
    safariVC.preferredBarTintColor = [UIColor hn_brandColor];
    safariVC.preferredControlTintColor = [UIColor hn_navigationTintColor];
}

SFSafariViewController *safariVCForURL(NSURL *url) {
    SFSafariViewController *safariVC = nil;

    if (@available(iOS 11.0, *)) {
        SFSafariViewControllerConfiguration *configuration = [SFSafariViewControllerConfiguration new];
        
        //configuration.entersReaderIfAvailable = YES;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            configuration.barCollapsingEnabled = YES;
        }
        else {
            configuration.barCollapsingEnabled = NO;
        }
        
        safariVC = [[SFSafariViewController alloc] initWithURL:url
                                                 configuration:configuration];
    }
    else {
        safariVC = [[SFSafariViewController alloc] initWithURL:url];
    }
    
    hn_enableAppearance(safariVC);

    if (@available(iOS 11.0, *)) {
        safariVC.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleClose;
    }

    return safariVC;
}

UIViewController *viewControllerForPost(HNPost *post) {
    UIViewController *controller;
    if ([post.URL isHackerNewsURL]) {
        NSUInteger postID = [[post.URL hn_valueForQueryParameter:@"id"] integerValue];
        controller = [[HNCommentViewController alloc] initWithPostID:postID];
    } else {
        controller = safariVCForURL(post.URL);
    }
    controller.hidesBottomBarWhenPushed = YES;
    return controller;
}

UIViewController *viewControllerForURL(NSURL *url) {
    UIViewController *controller;
    if ([url isHackerNewsURL]) {
        NSUInteger postID = [[url hn_valueForQueryParameter:@"id"] integerValue];
        controller = [[HNCommentViewController alloc] initWithPostID:postID];
    } else {
        controller = safariVCForURL(url);
    }
    controller.hidesBottomBarWhenPushed = YES;
    return controller;
}
