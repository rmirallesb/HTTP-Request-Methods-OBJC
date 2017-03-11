//
//  ViewController.h
//  TestHTTPGET
//
//  Created by Raul on 11/3/17.
//  For enable http not secure connections go to -> Project icon/Targets/Info/Add group "Add Transport Security Settings", Add "Allow Arbitrary Loads" with YES
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *text1;
@property (nonatomic, strong) IBOutlet UILabel *text2;

@property (weak, nonatomic)   IBOutlet UIButton *btnHttpGet;
@property (weak, nonatomic)   IBOutlet UIButton *btnHttpGetHeader;

- (void)httpPost;
- (IBAction)httpGet;
- (IBAction)httpGetHeader;

@end
