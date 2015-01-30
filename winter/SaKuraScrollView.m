//
//  SaKUIScrollView.m
//  winter
//
//  Created by command.Zi on 15/1/26.
//  Copyright (c) 2015年 command.Zi. All rights reserved.
//

#import "SaKuraScrollView.h"

@interface SaKuraScrollView () <UIScrollViewDelegate>{
    NSMutableArray * tempimagesMutableArray;
}

@property (strong, nonatomic) UIPageControl * pageControlView;
@property (strong, nonatomic) UIScrollView * myScrollView;
@property (strong, nonatomic) UITapGestureRecognizer * TapGestureRecognizer;


@end

@implementation SaKuraScrollView

-(instancetype)init {
    if(self = [super init]){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

-(void)setup {
    self.myScrollView = [[UIScrollView alloc]init];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.delegate = self;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.showsVerticalScrollIndicator = NO;
    
    self.TapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
    [self.myScrollView addGestureRecognizer:self.TapGestureRecognizer];
}

-(UIPageControl *)pageControlView {
    if (_pageControlView) {
        return _pageControlView;
    }else {
        UIPageControl * pageControlView = [[UIPageControl alloc]init];
        [self addSubview:self.myScrollView];
        [self addSubview:pageControlView];
        _pageControlView = pageControlView;
        return pageControlView;
    }
}

-(void)setImagesMutableArray:(NSMutableArray *)imagesMutableArray {
    _imagesMutableArray = imagesMutableArray;
    tempimagesMutableArray = [[NSMutableArray alloc]initWithArray:imagesMutableArray];
    
    self.pageControlView.numberOfPages = [imagesMutableArray count];
    CGFloat pageControlViewWidth = 12*[imagesMutableArray count];
    self.pageControlView.frame = CGRectMake(self.frame.size.width/2-pageControlViewWidth/2, self.frame.size.height-30, pageControlViewWidth, 20);
    
    UIImage * aa = imagesMutableArray[0];
    UIImage * zz = imagesMutableArray[[imagesMutableArray count]-1];
    [tempimagesMutableArray insertObject:zz atIndex:0];
    [tempimagesMutableArray addObject:aa];
    
    self.myScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.myScrollView.contentSize = CGSizeMake(self.frame.size.width*[tempimagesMutableArray count], self.frame.size.height);
    [self.myScrollView setContentOffset:CGPointMake(self.myScrollView.frame.size.width, 0)];   //设置显示数组第二站图

    for (int i = 0; i<tempimagesMutableArray.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
        img.image = tempimagesMutableArray[i];
        [self.myScrollView addSubview:img];
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat nowPage = scrollView.contentOffset.x/self.frame.size.width;
    self.pageControlView.currentPage = nowPage-1;
    
    if (scrollView.contentOffset.x <=0) {
        //该处判断scrollView滚动到第[0]张image时，则scrollView的image显示为倒数第二张
        CGPoint abc = CGPointMake(self.frame.size.width*(tempimagesMutableArray.count-2), 0);
        [scrollView setContentOffset:abc animated:NO];
    }if (scrollView.contentOffset.x>=(tempimagesMutableArray.count-1)*self.frame.size.width) {
        //该处判断scrollView滚动到倒数第一张的image时，则scrollView的image显示为第二张
        CGPoint abc = CGPointMake(self.frame.size.width, 0);
        [scrollView setContentOffset:abc animated:NO];
    }
}

//加自动滚动,判断只有一张

-(void)SingleTap:(UITapGestureRecognizer*)recognizer {
    [self.sakuraDelegate selectPageAtScrollView:self.myScrollView selectPage:self.pageControlView.currentPage];
}

@end
