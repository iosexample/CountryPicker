//
//  CountryPickerViewController.m
//  CountryPickerDemo
//
//  Created by Theodore Gonzalez on 1/15/17.
//
//

#import "CountryPickerViewController.h"
#import "CountryTableViewCell.h"
#import "CountryPicker.h"
#import "CountryModel.h"
#define LangId @"en_US"  //change Localized country from here for Egypt  set LangId as @"ar_EG"


@interface CountryPickerViewController ()
<UITableViewDelegate, UITableViewDataSource,
UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (nonatomic) NSMutableArray<CountryModel *> *countryModels;
@property (nonatomic) NSArray<CountryModel *> *tableItems;
@end

@implementation CountryPickerViewController
static NSDictionary *dialCode;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tv registerNib:[UINib nibWithNibName:@"CountryTableViewCell" bundle:nil] forCellReuseIdentifier:@"CountryTableViewCell"];
    self.tableItems =  self.countryModels.copy;
}
-(void)setTableItems:(NSMutableArray<CountryModel *> *)tableItems {
    _tableItems = tableItems;
    [self.tv reloadData];
}
#pragma mark - Data

+ (NSDictionary *)diallingCodes
{
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        // Do some work that happens once
        NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"DiallingCodes" ofType:@"plist"];
        dialCode = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    });
    
    return dialCode;
}
- (NSMutableArray *)countryModels
{
    if (!_countryModels) {
        _countryModels = [NSMutableArray new];
        NSArray *unknownCodes = @[@"BV",@"BQ",@"CX",@"CC",@"CW",@"TF",@"GG",@"HM",@"IM",@"JE",@"YT",@"NF",@"PN",@"BL",@"MF",@"GS",@"SS",@"SJ",@"TL",@"UM",@"EH"];
        
        for (NSString *code in [NSLocale ISOCountryCodes])
        {
            NSString *countryName = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:code];
            
            //workaround for simulator bug
            if (!countryName)
            {
                countryName = [[NSLocale localeWithLocaleIdentifier:LangId] displayNameForKey:NSLocaleCountryCode value:code];
            }
            
            if ([unknownCodes containsObject:code] == NO) {
                CountryModel *model = [CountryModel new];
                model.name = countryName ?: code;
                model.code = code;
                model.phoneExtension = [[self class] diallingCodes][code.lowercaseString];

                [_countryModels addObject:model];
            }
        }
    }
    return _countryModels;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(__unused UITableView *)tableView numberOfRowsInSection:(__unused NSInteger)section {
    return (NSInteger)self.tableItems.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = (NSUInteger)indexPath.row;
    CountryModel *model = self.tableItems[row];
    
    UIImage *image;
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@", model.code];
    if ([[UIImage class] respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)])
        image = [UIImage imageNamed:imagePath inBundle:[NSBundle bundleForClass:[CountryPicker class]] compatibleWithTraitCollection:nil];
    else {
        image = [UIImage imageNamed:imagePath];
    }
    
    CountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryTableViewCell" forIndexPath:indexPath];
    cell.lbCountryCode.text = model.phoneExtension;
    cell.lbCountryName.text = model.name;
    cell.ivFlag.image       = image;
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(__unused UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar endEditing:YES];
    NSUInteger row = (NSUInteger)indexPath.row;
    CountryModel *model = self.tableItems[row];
    
    __strong id<CountryPickerViewControllerDelegate> strongDelegate = self.delegate;
    [strongDelegate countryPickerViewController:self didSelectCountryWithName:model.name code:model.code dialCode:model.phoneExtension];
}
#pragma mark - UISearchBarDelegate
- (void)searchBar:(__unused UISearchBar *)searchBar textDidChange:(nonnull NSString *)searchText {
    if ([searchText isKindOfClass:[NSString class]] && searchText.length > 0) {
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@", searchText];
        self.tableItems = [self.countryModels filteredArrayUsingPredicate:bPredicate];
    } else {
        self.tableItems = self.countryModels.copy;
    }
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
}
@end
