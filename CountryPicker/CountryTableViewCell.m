//
//  CountryTableViewCell.m
//  CountryPickerDemo
//
//  Created by Theodore Gonzalez on 1/15/17.
//
//

#import "CountryTableViewCell.h"

@implementation CountryTableViewCell

@synthesize ivFlag;
@synthesize lbCountryName;
@synthesize lbCountryCode;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
