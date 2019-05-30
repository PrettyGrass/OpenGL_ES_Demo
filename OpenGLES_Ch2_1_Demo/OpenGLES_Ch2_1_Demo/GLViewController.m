//
//  GLViewController.m
//  OpenGLES_Ch2_1_Demo
//
//  Created by liaoshuhua on 2019/5/30.
//  Copyright © 2019 BHB. All rights reserved.
//

#import "GLViewController.h"

@interface GLViewController()

@property(nonatomic, assign) GLuint vertexBufferID;//顶点缓存标示符

/*
 GLKBaseEffect是GLKit的内建类，目的为了简化OpenGL ES的很多操作。它影藏了iOS设备支持
 的多个OpenGL ES版本之间的差异。在应用中使用GLKBaseEffect能减少需要编写的代码量。(替代了着色器
 相关功能)
 */
@property(nonatomic, strong) GLKBaseEffect  *baseEffect;
@end

typedef struct{
    
    GLKVector3 positionCoords; //位置坐标
}SceneVertex; //屏幕顶点结构体

static const SceneVertex vertices[] = {
    
    {{-0.5f, -0.5f, 0.0f}},
    {{0.5f, -0.5f, 0.0f}},
    {{-0.5f, 0.5f, 0.0f}}
};

@implementation GLViewController

- (void)dealloc
{
    NSLog(@"=====GLViewController dealloc");
    if (self.vertexBufferID != 0)
    {
        glDeleteBuffers(1, &_vertexBufferID);
        _vertexBufferID = 0;
    }
    [EAGLContext setCurrentContext:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass:[GLKView class]], @"====当前view不是GLKView 类");
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    [EAGLContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    //设置三角形颜色固定
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0, 0.0, 0.0, 1.0);
    //设置背景色(清除色：用于在上下文的帧缓存被清除时初始化每个像素的颜色值)
    glClearColor(1.0, 1.0, 1.0, 1.0);
    
    //1、创建缓存
    glGenBuffers(1, &_vertexBufferID);
    //2、绑定缓存
    glBindBuffer(GL_ARRAY_BUFFER, self.vertexBufferID);
    
    /**
     3、复制数据到绑定的缓存中
     参数一：用于指定要更新当前上下文所绑定的是哪个一个缓存
     参数二：指定要复制进这个缓存的字节的数量
     参数三：要复制的字节的地址
     参数四：提示缓存在未来的运算中可能被怎么使用。GL_STATIC_DRAW提示会告诉上下文，
     缓存中的内容适合复制到GPU控制的内存，以为很少对其进行修改。可以帮助OpenGL ES优化内存
     使用。使用GL_DYNAMIC_DRAW，会告诉上下文，缓存的数据会频繁的改变，同时提示OpenGL ES
     以不同的方式来处理缓存的存储
     */
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [self.baseEffect prepareToDraw];
    //清除颜色缓存，设置之前调用glClearColor()设置的背景色
    glClear(GL_COLOR_BUFFER_BIT);
    
    //1、启动顶点缓存渲染操作
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    /**
     2、设置指针
     这个函数会告诉OpenGL ES顶点数据在哪里，以及怎么解释为每个顶点保存的数据，

     @param GLKVertexAttribPosition 指示当前绑定的缓存包含每个顶点的位置信息
     @param 3 指示每个位置有3个部分
     @param GL_FLOAT 每个部分都保存为一个浮点型的值
     @param GL_FALSE 小数点固定数据是否可以被改变
     @param SceneVertex 步幅，指定了每个顶点的保存需要多少个字节，即从这个顶点到下个顶点内存开始位置需要跳过多少字节
     @param NULL 告诉OpenGL ES可以从当前绑定的顶点缓存的开始位置访问顶点数据
     */
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL);
    
    /*
     3、绘图
     参数一: 告诉GPU怎么处理在绑定的顶点缓存内的顶点数据
     参数二: 指定缓存内需要渲染的第一个顶点的位置
     参数三: 指定缓存内需要渲染的顶点数量
     */
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

@end
