#import <UIKit/UIKit.h>

CG_EXTERN NSString *const PestoDataBaseURL;

@interface PestoData : NSObject

@property(nonatomic) NSArray *authors;
@property(nonatomic) NSArray *iconNames;
@property(nonatomic) NSArray *imageFileNames;
@property(nonatomic) NSArray *titles;

@end
