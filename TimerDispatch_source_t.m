//
//  TimerDispatch_source_t.m
//  Dispatch_source_t_20170715
//
//  Created by yetaiwen on 17/7/5.
//  Copyright © 2017年 yetaiwen. All rights reserved.
//

#import "TimerDispatch_source_t.h"

@interface TimerDispatch_source_t ()
{
    UILabel *_displayLabel;
    dispatch_source_t _timer;
}
@end

@implementation TimerDispatch_source_t

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.bounds = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, 50);
    startBtn.backgroundColor = [UIColor yellowColor];
    [startBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    startBtn.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2 - 25);
    [startBtn addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UILabel *displayLabel = [[UILabel alloc]init];
    displayLabel.backgroundColor = [UIColor lightGrayColor];
    displayLabel.bounds = startBtn.bounds;
    displayLabel.text = @"ready";
    displayLabel.textAlignment = UITextAlignmentCenter;
    displayLabel.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height /4 - 25);
    [self.view addSubview:displayLabel];
    _displayLabel = displayLabel;
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.bounds = CGRectMake(0, 0, self.view.bounds.size.width * 0.5, 50);
    stopBtn.backgroundColor = [UIColor redColor];
    [stopBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [stopBtn setTitle:@"stop" forState:UIControlStateNormal];
    stopBtn.center = CGPointMake(self.view.bounds.size.width/2, 3 * self.view.bounds.size.height /4 - 25);
    [stopBtn addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)startTimer
{
    //timer 运行的线程
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建timer
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatchQueue);
    //设置timer开始时间、间隔时间、偏差
    //1.DISPATCH_TIME_NOW
    //    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //2.dispatch_walltime
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //timer执行体
    __block int i = 0;
    dispatch_source_set_event_handler(_timer, ^{
        //        NSLog(@"timer executed code");
        //回主线程操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [_displayLabel setText:[NSString stringWithFormat:@"%d",i++]];
            
        });
    });
    //启动timer
    dispatch_resume(_timer);
    
}

- (void)stopTimer
{
    //停止timer
    dispatch_source_cancel(_timer);
    _timer = nil;
    [_displayLabel setText:@"stoped the timer"];
    NSLog(@"timer:%@",_timer);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
