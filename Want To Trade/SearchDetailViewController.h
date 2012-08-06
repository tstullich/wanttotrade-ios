//
//  SearchDetailViewController.h
//  Want To Trade
//
//  Created by Sam  on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface SearchDetailViewController : UIViewController{
    UIImageView *bookImage;
    UILabel *bookTitleLabel;
    UILabel *bookAuthorLabel;
    UILabel *bookPriceLabel;
    UILabel *bookEditionLablel;
    UILabel *bookConditionLabel;
    Book *receivedBook;
}

@property (nonatomic, retain) IBOutlet UIImageView *bookImage;
@property (nonatomic, retain) IBOutlet UILabel *bookTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *bookAuthorLabel;
@property (nonatomic, retain) IBOutlet UILabel *bookPriceLabel;
@property (nonatomic, retain) IBOutlet UILabel *bookEditionLablel;
@property (nonatomic, retain) IBOutlet UILabel *bookConditionLabel;
@property (nonatomic, retain) Book *receivedBook;

-(void)addBook;

@end