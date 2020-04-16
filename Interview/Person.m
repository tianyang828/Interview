//
//  Person.m
//  Interview
//
//  Created by 田洋 on 2019/9/26.
//  Copyright © 2019 田洋. All rights reserved.
//

#import "Person.h"
#import <Foundation/Foundation.h>
@interface Person ()

//这是属性，不是实例变量
//@property (nonatomic, strong) NSString *name;
//@dynamic name;//告诉编译器不要生成
@end

@implementation Person

//@synthesize是为属性添加一个实例变量名，或者说别名_myName。同时会为该属性生成 setter/getter 方法
//当我们同时重写了setter and getter方式时，系统会报错，原因是找不到实例变量。其解决方法: 在.m的文件中使用@synthesize
@synthesize name = _myName;

//如果某属性已经在某处实现了自己的 setter/getter ,可以使用 @dynamic来阻止 @synthesize 自动生成新的 setter/getter 覆盖。
//@dynamic name;

- (NSString *)name{
    return _myName;
}

- (void)setName:(NSString *)name{
    _myName = name;
}

- (void)test{
    NSLog(@"\n名字 = %@\n",self.name);
}

@end
//https://www.jianshu.com/p/0695ecbe9e06
/**
 
 @synthesize和@dynamic分别有什么作用？
 @property有两个对应的词，一个是 @synthesize，一个是 @dynamic。如果 @synthesize和 @dynamic都没写，那么默认的就是@syntheszie var = _var;
 @property = ivar + getter + setter;

 @synthesize 的语义是如果你没有手动实现 setter 方法和 getter 方法，那么编译器会自动为你加上这两个方法。

 @dynamic 告诉编译器：属性的 setter 与 getter 方法由用户自己实现，不自动生成。（当然对于 readonly 的属性只需提供 getter 即可）。假如一个属性被声明为 @dynamic var，然后你没有提供 @setter方法和 @getter 方法，编译的时候没问题，但是当程序运行到 instance.var = someVar，由于缺 setter 方法会导致程序崩溃；或者当运行到 someVar = var 时，由于缺 getter 方法同样会导致崩溃。编译时没问题，运行时才执行相应的方法，这就是所谓的动态绑定。
 */

