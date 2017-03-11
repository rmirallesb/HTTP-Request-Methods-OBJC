//
//  ViewController.m
//  TestHTTPGET
//
//  Created by Raul on 11/3/17.
//  For enable http not secure connections go to -> Project icon/Targets/Info/Add group "Add Transport Security Settings", Add "Allow Arbitrary Loads" with YES
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  httpPost];
    [self  httpGetHeader];
    [self  httpGet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// HTTP POST
- (void)httpPost {
    NSMutableURLRequest *url        = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://wwww.web.com"]];
    NSString            *parameters = [NSString stringWithFormat:@"username=%@&password=%@",@"",@""];
    NSData              *data       = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    [url setHTTPMethod:@"POST"];
    [url setHTTPBody:data];
    
    NSURLSession            *session            = [NSURLSession sharedSession];
    NSURLSessionDataTask    *sessionDataTask    = [session dataTaskWithRequest:url
                                                             completionHandler:^(NSData        *data1,
                                                                                 NSURLResponse *response,
                                                                                 NSError       *error) {
        NSHTTPURLResponse   *httpResponse       = (NSHTTPURLResponse *)response;
                                                                 
        if (httpResponse.statusCode == 200) {
            NSError         *parseError         = nil;
            NSDictionary    *responseDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                  options:0
                                                                                    error:&parseError];
            NSString        *key                = [responseDictionary objectForKey:@"key"];
                                                                     
            NSLog(@"%@",responseDictionary);
            NSLog(@"%@",key);
        } else {
            NSLog(@"Error");
        }
    }];
    
    [sessionDataTask resume];
}

// HTTP GET fetching data from JSON
- (IBAction)httpGet {
    NSURL        *url       = [NSURL URLWithString:@"http://rest-service.guides.spring.io/greeting"];
    NSURLRequest *request   = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData        *data,
                                               NSError       *connectionError) {
         if (data.length > 0 && connectionError == nil) {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             self.text1.text        = [[greeting objectForKey:@"id"] stringValue];
             self.text2.text        = [greeting  objectForKey:@"content"];
         }
     }];
}

// HTTP GET with Header fetching data from JSON
- (IBAction)httpGetHeader {
    NSURL               *url            = [NSURL URLWithString:@"https://your-url"];
    NSURLRequest        *request        = [NSURLRequest requestWithURL:url];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    [mutableRequest addValue:@"your-value"
          forHTTPHeaderField:@"your-header"];
    
    request = [mutableRequest copy];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData        *data,
                                               NSError       *connectionError) {
         if (data.length > 0 && connectionError == nil) {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             for(NSDictionary *result in [greeting objectForKey:@"key"]){
                 self.text1.text    = [[result valueForKey:@"data1"]substringFromIndex:3];
                 self.text2.text    = [result  valueForKey:@"data2"];
             }
         }
     }];
}

@end
