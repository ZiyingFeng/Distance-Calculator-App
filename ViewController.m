//
//  ViewController.m
//  DistanceCalculation
//
//  Created by Ziying Feng on 2/7/17.
//  Copyright © 2017 Ziying Feng. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *startLoc;

@property (weak, nonatomic) IBOutlet UITextField *endLocA;
@property (weak, nonatomic) IBOutlet UILabel *distanceA;

@property (weak, nonatomic) IBOutlet UITextField *endLocB;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;

@property (weak, nonatomic) IBOutlet UITextField *endLocC;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;

@property (weak, nonatomic) IBOutlet UIButton *calculationButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectSegment;

@property (nonatomic) NSArray<UILabel*> *labelArray;

@end

@implementation ViewController



- (IBAction)calculationButton:(id)sender {
   
    
    
    self.calculationButton.enabled = NO;
    
    self.req = [DGDistanceRequest alloc];
    //if not alloc before, the callback function will not run
    
    NSString *startSource = self.startLoc.text;
    NSString *endA = self.endLocA.text;
    NSString *endB = self.endLocB.text;
    NSString *endC = self.endLocC.text;
    
    NSArray *ends = @[endA, endB, endC];
    
    self.req = [self.req initWithLocationDescriptions: ends sourceDescription: startSource];
    
    self.labelArray = @[self.distanceA, self.distanceB, self.distanceC];
    
    __weak ViewController *weakSelf = self;
    self.req.callback = ^(NSArray *distances){
        
        if(!weakSelf) return;
        
        NSNull *badResult = [NSNull null];
        //NULL nothing for pointers, nil object pointer points to nothing, NSNull effectively boxing NULL or nil value so that it can be used in collections cuz collections like NSArray and NSDictionary not being able to contain nil values; In this case, without this line, it will throws an exeption if you didn't enter anything in TextField and press the Button. http://nshipster.com/nil/
        
        for(int k = 0; k < 3; k++){
            NSString *distanceOutput;
            
            if (distances[k] != badResult){
                double value = [distances[k] floatValue];
                
                if (weakSelf.selectSegment.selectedSegmentIndex == 0){
                    
                    distanceOutput = [NSString stringWithFormat:@"%.2f km", value/1000.0];
                }
                else{
                    distanceOutput = [NSString stringWithFormat:@"%.2f mile", value*0.000621371];
                }
                
            }
            
            else{
                distanceOutput = @"ERROR";
            }
            
            weakSelf.labelArray[k].text = distanceOutput;
        }
        
//        if(distances[0] != badResult){
//            
//            double valueA = [distances[0] floatValue];
//            double valueB = [distances[1] floatValue];
//            double valueC = [distances[2] floatValue];
//            
//            if (self.selectSegment.selectedSegmentIndex == 0){
//            
//                NSString *distanceAoutput = [NSString stringWithFormat:@"%.2f km", valueA/1000.0];
//                weakSelf.distanceA.text = distanceAoutput;
//            
//                NSString *distanceBoutput = [NSString stringWithFormat:@"%.2f km", valueB/1000.0];
//                weakSelf.distanceB.text = distanceBoutput;
//                
//                NSString *distanceCoutput = [NSString stringWithFormat:@"%.2f km", valueC/1000.0];
//                weakSelf.distanceC.text = distanceCoutput;
//            
//            
//            }
//            
//            else{
//                NSString *distanceAoutput = [NSString stringWithFormat:@"%.2f miles", valueA*0.000621371];
//                weakSelf.distanceA.text = distanceAoutput;
//                
//                NSString *distanceBoutput = [NSString stringWithFormat:@"%.2f miles", valueB*0.000621371];
//                weakSelf.distanceB.text = distanceBoutput;
//                
//                NSString *distanceCoutput = [NSString stringWithFormat:@"%.2f miles", valueC*0.000621371];
//                weakSelf.distanceC.text = distanceCoutput;
//                
//                
//            }
//            
//           
//        
//        }
//        else{
//            weakSelf.distanceA.text = @"ERROR";
//        }
//        
        weakSelf.calculationButton.enabled = YES;
        

    };
    
    [self.req start];
    
    [self.startLoc resignFirstResponder];
    [self.endLocA resignFirstResponder];
    [self.endLocB resignFirstResponder];
    [self.endLocC resignFirstResponder];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    
}


@end
