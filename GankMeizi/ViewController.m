//
//  ViewController.m
//  GankMeizi
//
//  Created by 张威 on 2018/9/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "GankMeizi.h"
#import "MeiziCell.h"
#import "DYTWaterflowLayout.h"
#import <SDWebImage/SDWebImageManager.h>

@interface ViewController ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *meiziArray;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) DYTWaterflowLayout *waterflowLayout;
@property (nonatomic, assign) DirectionType type;

@property (nonatomic, strong) NSMutableArray *widths;
@property (nonatomic, strong) NSMutableArray *heights;
@property (nonatomic, strong) NSMutableArray *picImageArr;


@end

@implementation ViewController

static NSString * const reuseIdentifier = @"CollectionViewCell";
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _page = 1;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView.mj_header beginRefreshing];
    

    
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView.collectionViewLayout finalizeCollectionViewUpdates];
}
#pragma mark - CollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%ld",self.meiziArray.count) ;
    return self.meiziArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screeWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    NSInteger perLine = ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait)?3:5;
    return CGSizeMake(screeWidth/perLine-1, screeWidth/perLine-1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MeiziCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MeiziCell" forIndexPath:indexPath];
    [cell setMeizi:((Result *)self.meiziArray[indexPath.row])];
    
    return cell;
   
}

-(void)getMeiziArray:(NSInteger) page{
    
    NSString * meiziurl = [NSString stringWithFormat:@"https://gank.io/api/data/福利/20/%@",@(page)];
    meiziurl = [meiziurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    __block GankMeizi *gank;
    [manager GET:meiziurl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject);
        gank = [GankMeizi mj_objectWithKeyValues:responseObject];
        if (gank.results.count ){
        NSLog(@"%@",((Result*)gank.results[0]).url);
        if (page == 1) {
            [self.meiziArray removeAllObjects];
        }
        self.page++;
        [self.meiziArray addObjectsFromArray:gank.results];//= [NSMutableArray arrayWithArray:gank.results];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        }else {
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
            
        
        
        // 请求成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
    }];
    NSLog(@"%@",gank);
    
    
    
}


#pragma mark 刷新调用的方法
-(void)refreshMeizi{
    self.page = 1;
    [self.meiziArray removeAllObjects];
    [self getMeiziArray:self.page];
}
#pragma mark 加载更多调用的方法
-(void)loadMoreMeizi{
    [self getMeiziArray:self.page+1];
    
}
#pragma mark 懒加载
- (NSMutableArray *)meiziArray {
    if (_meiziArray == nil) {
        
        _meiziArray = [[NSMutableArray alloc] init];
    }
    //NSLog(@"妹子的数量%ld",_meiziArray.count);
    return _meiziArray;
}
#pragma mark 懒加载
- (UICollectionView *)collectionView {
    UICollectionView *collectionView = [super collectionView];
    if (collectionView.mj_header == nil) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshMeizi)];
        header.automaticallyChangeAlpha = YES;
        collectionView.mj_header = header;
    }
    if (collectionView.mj_footer == nil) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMeizi)];
        footer.automaticallyRefresh = YES;
        collectionView.mj_footer = footer;
    }
    return collectionView;
}

- (NSMutableArray *)picImageArr {
    
    if (!_picImageArr) {
        _picImageArr = [[NSMutableArray alloc] init];
    }
    return _picImageArr;
}

- (NSMutableArray *)heights {
    
    if (!_heights) {
        _heights = [[NSMutableArray alloc] init];
    }
    return _heights;
}

- (NSMutableArray *)widths {
    
    if (!_widths) {
        _widths = [[NSMutableArray alloc] init];
    }
    return _widths;
}



@end
