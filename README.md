# Objective-C-Demos
collection of my OC demos
```
  //timer 运行的线程
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatchQueue);
    //设置timer开始时间、间隔时间、偏差
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //timer执行体
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"timer executed code");
    });
    //启动timer
    dispatch_resume(timer);
    
    //停止timer
    dispatch_source_cancel(timer);
    ```
   
   ![timer.png](http://upload-images.jianshu.io/upload_images/2737326-4a92ed10e5cdccee.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
