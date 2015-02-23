//
//  ChatViewController.m
//  ExerciseW3
//
//  Created by AP Fritts on 2/22/15.
//  Copyright (c) 2015 Box. All rights reserved.
//

#import "ChatViewController.h"
#import "MessageCell.h"
#import <Parse/Parse.h>

@interface ChatViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *messages;
@property (assign, nonatomic) BOOL updating;

@property (weak, nonatomic) IBOutlet UITextField *messageField;
- (IBAction)sendTap:(id)sender;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"MessageCell"];
    self.messageField.delegate = self;
    
    NSLog(@"%@", [PFUser currentUser]);
    
    self.updating = NO;
    [self updatesMessages];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector: @selector(updatesMessages) userInfo:nil repeats:YES];
}

-(void)updatesMessages {
    if (!self.updating) {
        self.updating = YES;
        PFQuery *messages = [PFQuery queryWithClassName:@"Message"];
        [messages findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            self.updating = NO;
            if (!error) {
                self.messages = objects;
                [self.messages sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    PFObject *pfObj1 = (PFObject *)obj1;
                    PFObject *pfObj2 = (PFObject *)obj2;
                    return [pfObj1.createdAt compare:pfObj2.createdAt];
                }];
                [self.tableView reloadData];
                [self.tableView scrollRectToVisible:CGRectMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height, self.tableView.bounds.size.width, self.tableView.bounds.size.height) animated:YES];
            }
        }];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages ? self.messages.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    cell.messageLabel.text = self.messages[indexPath.row][@"text"];
    return cell;
}

- (IBAction)sendTap:(id)sender {
    [self sendMessage];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendMessage];
    return YES;
}

-(void)sendMessage {
    [self.messageField resignFirstResponder];
    PFObject *msg = [PFObject objectWithClassName:@"Message"];
    msg[@"text"] = self.messageField.text;
    self.messageField.text = @"";
    [msg saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self updatesMessages];
        }
    }];
}

@end
