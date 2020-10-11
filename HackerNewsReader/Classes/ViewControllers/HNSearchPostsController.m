//
//  HNSearchPostsController.m
//  HackerNewsReader
//
//  Created by Ryan Nystrom on 6/6/15.
//  Copyright (c) 2015 Ryan Nystrom. All rights reserved.
//

#import "HNSearchPostsController.h"

#import "HNReadPostStore.h"
#import "NHResultsController.h"
#import "UIColor+HackerNews.h"

@interface HNSearchPostsController () <UISearchResultsUpdating>

@end

@implementation HNSearchPostsController

- (instancetype)initWithOriginalController:(UIViewController *)viewController andReadPostStore:(HNReadPostStore *)readPostStore {
    NHResultsController *resultsController = [[NHResultsController alloc]
            initWithOriginalController:viewController
                      andReadPostStore:readPostStore];

    if (self = [super initWithSearchResultsController:resultsController]) {
        self.hidesNavigationBarDuringPresentation = YES;
        self.searchResultsUpdater = self;

        if (@available(iOS 11.0, *)) {
            [self hn_themeSearchBar];
        }
    }

    return self;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *query = searchController.searchBar.text/*.lowercaseString*/;
    NSPredicate *titlePredicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", query];
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"URL.absoluteString CONTAINS[cd] %@", query];
    NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[titlePredicate, urlPredicate]];

    NSArray *filteredPosts = [self.posts filteredArrayUsingPredicate:predicate];

    NHResultsController *resultsController = (NHResultsController *) self.searchResultsController;
    [resultsController setPosts:filteredPosts];
}

#pragma mark - Private

// hn_enableAppearance
- (void)hn_themeSearchBar {
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.backgroundColor = [UIColor clearColor];

    UITextField *textField = [self.searchBar valueForKey:@"searchField"];
    UIView *backgroundView = textField.subviews.firstObject;
    backgroundView.backgroundColor = [UIColor hn_navigationTintColor];
    backgroundView.layer.cornerRadius = 10;
    backgroundView.clipsToBounds = YES;
}

@end
