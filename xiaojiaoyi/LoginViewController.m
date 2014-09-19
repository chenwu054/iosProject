//
//  LoginViewController.m
//  xiaojiaoyi
//
//  Created by chen on 8/24/14.
//  Copyright (c) 2014 com.practice. All rights reserved.
//

#import "LoginViewController.h"
#import "STTwitterOAuth.h"
#import "STTwitterAPI.h"
#import "OAuthViewController.h"
//#import "STTwitter/STTwitterOAuth.h"



#define LOGIN_LABEL @"log in"
#define LOGIN_USERNAME @"username"
#define LOGIN_PASSWORD @"password"
#define TWITTER_CONSUMER_NAME @"xiaojiaoyi"
#define TWITTER_CONSUMER_KEY /*@"sRtlhqgVCwIFNooYsr8X1sptO"*/ @"PdLBPYUXlhQpt4AguShUIw"
#define TWITTER_CONSUMER_SECRET /*@"JomNUiwkkHoZ9I1jhwyUbtDBWoLrHMmBB61CoYf9t57l5z2x8h"*/ @"drdhGuKSingTbsDLtYpob4m5b5dn1abf9XXYyZKQzk"
#define LINKEDIN_API_KEY @"75iapcxav6yub5"
#define LINKEDIN_DEFAULT_SCOPE @"r_basicprofile"
#define LINKEDIN_DEFAULT_STATE @"ThisIsARandomeState"
#define LINKEDIN_REDIRECT_URL @"http://xiaojiaoyi_linkedin_redirectURL"
#define LINKEDIN_SECRET @"jUcSjy0xlLY0oaJC"
#define LINKEDIN_AUTHENTICATION_CODE_BASE_URL @"https://www.linkedin.com/uas/oauth2/authorization?response_type=code"


@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *loginUsernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;
@property (weak, nonatomic) IBOutlet UIButton *loginForgetPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *loginLinkedinButton;

@property (weak, nonatomic) IBOutlet UILabel *loginProceedLabel;
//@property (nonatomic,weak) UITapGestureRecognizer *tapRecognizer;
//@property (weak,nonatomic) FBLoginView *fbLoginView;
@property  (nonatomic) IBOutlet FBLoginView *fbLoginView;

@property (strong, nonatomic) STTwitterAPI * twitterAPI;



@end

@implementation LoginViewController

- (void) setFbLoginView:(FBLoginView *)fbLoginView
{
    if(!_fbLoginView){
        _fbLoginView = [[FBLoginView alloc] init];
        _fbLoginView.delegate = self;
    }
}


#pragma mark - controllerLifeCycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     login button setup
     */
    //self.view.backgroundColor = [UIColor grayColor];
    self.loginLoginButton.backgroundColor = [UIColor blueColor];
    self.loginLoginButton.titleLabel.textColor = [UIColor whiteColor];
    self.loginLoginButton.titleLabel.text = LOGIN_LABEL;
    
    /*
     username text field setup
     */
    self.loginUsernameTextField.delegate = self;
    self.loginUsernameTextField.placeholder = LOGIN_USERNAME;
    self.loginUsernameTextField.clearsOnBeginEditing = YES;
    //self.loginUsernameTextField.clearsOnBeginEditing = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(textFieldDidEndEditing:)
                                          name:UITextFieldTextDidEndEditingNotification
                                          object:self];
    /*
     password text field setup
     */
    self.loginPasswordTextField.delegate = self;
    self.loginPasswordTextField.placeholder = LOGIN_PASSWORD;
    self.loginPasswordTextField.clearsOnBeginEditing = YES;
    self.loginPasswordTextField.secureTextEntry = YES;
    
    /*
     fb login view
     */
    //FBLoginView *fbLoginView = [[FBLoginView alloc] init];
    
    
}
#pragma mark - LinkedIn 

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Linkedin segue"]){
        NSLog(@"about to segue");
        if([segue.destinationViewController isKindOfClass:[OAuthViewController class]]){
            OAuthViewController *webViewController = (OAuthViewController*)segue.destinationViewController;
            webViewController.requestURL = [NSString stringWithFormat:@"https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=%@&scope=%@&state=%@&redirect_uri=%@",LINKEDIN_API_KEY,LINKEDIN_DEFAULT_SCOPE,LINKEDIN_DEFAULT_STATE,LINKEDIN_REDIRECT_URL];
        }
    }
}

-(IBAction)done:(UIStoryboardSegue *)segue
{
    NSLog(@"calling the unwind method");
    
    
}

#pragma mark - FB login delegate

- (void) loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSLog(@"the logged in user id: %@ and name: %@", [user objectID], [user name]);
    
}
- (void) loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    NSLog(@"you are logged in as");
    
}
- (void) loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    NSLog(@"you are logged out ");
}
- (void) loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
    
}

#pragma mark - UI component respond
- (void) textFieldDidEndEditing:(UITextField *)sender
{
    if(sender == self.loginUsernameTextField){
        [sender resignFirstResponder];
    }
    else if(sender == self.loginPasswordTextField){
        [sender resignFirstResponder];
    }
    else{
        NSLog(@"text field did end editing: invalid text field");
    }
}
-(BOOL) textFieldShouldReturn:(UITextField *)sender
{
    [sender resignFirstResponder];
    return YES;
}

- (IBAction)onLoginButtonClicked:(id)sender
{
    [self login];
}
- (IBAction)onRegisterButtonClicked:(id)sender
{
    NSLog(@"register button clicked");
}


- (IBAction)onForgetPasswordButtonClicked:(id)sender
{
    NSLog(@"forget password button clicked");
}
- (IBAction)tapOutsideToDismissKeyboard:(id)sender
{
    //NSLog(@"tap gesture recognized");
    [self.loginUsernameTextField resignFirstResponder];
    [self.loginPasswordTextField resignFirstResponder];
}

- (IBAction)onTwitterLoginButtonClicked:(UIButton *)sender
{
    //[STTwitterAPI twitterAPIAppOnlyWithConsumerName:TWITTER_CONSUMER_NAME consumerKey:TWITTER_CONSUMER_KEY consumerSecret:TWITTER_CONSUMER_SECRET];
    
    self.twitterAPI = [STTwitterAPI twitterAPIWithOAuthConsumerKey:TWITTER_CONSUMER_KEY consumerSecret:TWITTER_CONSUMER_SECRET];
    if(!self.twitterAPI){
        NSLog(@"twitter API is not null");
        NSLog(@"%@", _twitterAPI.userName);
    }
    
    [_twitterAPI postTokenRequest:^(NSURL *url, NSString *oauthToken) {
        NSLog(@"-- url: %@", url);
        NSLog(@"-- oauthToken: %@", oauthToken);
        
        [[UIApplication sharedApplication] openURL:url];

    } oauthCallback:@"https://dev.twitter.com/apps/new" errorBlock:^(NSError *error) {
        NSLog(@"there is an error during token request");
    }];
    
}


- (void)setOAuthToken:(NSString *)token oauthVerifier:(NSString *)verifier {
    
    [_twitterAPI postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
        NSLog(@"-- screenName: %@", screenName);
        /*
         At this point, the user can use the API and you can read his access tokens with:
         
         _twitter.oauthAccessToken;
         _twitter.oauthAccessTokenSecret;
         
         You can store these tokens (in user default, or in keychain) so that the user doesn't need to authenticate again on next launches.
         
         Next time, just instanciate STTwitter with the class method:
         
         +[STTwitterAPI twitterAPIWithOAuthConsumerKey:consumerSecret:oauthToken:oauthTokenSecret:]
         
         Don't forget to call the -[STTwitter verifyCredentialsWithSuccessBlock:errorBlock:] after that.
         */
        
    } errorBlock:^(NSError *error) {

        NSLog(@"-- %@", [error localizedDescription]);
    }];
}

#pragma mark - login logic
- (void)login
{
    NSLog(@"perform login logic");
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
