//
//  ViewController.m
//  GankMeizi
//
//  Created by 张威 on 2018/9/10.
//  Copyright © 2018年 张威. All rights reserved.
//
//呵呵又改回来了
#import "ViewController.h"
#import "GankMeizi.h"
#import "MeiziCell.h"
#import "XHWaterfallFlowLayout.h"
#import "XRImage.h"


@interface ViewController ()<UICollectionViewDelegateFlowLayout,XHWaterfallFlowLayoutDelegate,YBImageBrowserDataSource>

@property (nonatomic, strong) NSMutableArray *meiziArray;
@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) XHWaterfallFlowLayout * flowLayout;
@property (nonatomic, strong) NSMutableArray *picImageArr;


@end

@implementation ViewController
{
    NSIndexPath *currentTouchIndexPath;
}
static NSString * const reuseIdentifier = @"MeiziCell";
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _page = 1;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _flowLayout = [[XHWaterfallFlowLayout alloc] init];
    _flowLayout.columnCount = 3;
    _flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    _flowLayout.minimumInteritemSpacing = 5;
    _flowLayout.minimumLineSpacing = 5;
    _flowLayout.sDelegate = self;
    
    
    [self.collectionView registerClass:[MeiziCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view, typically from a nib.
    [self.collectionView.mj_header beginRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    
    
    self.collectionView.collectionViewLayout = self.flowLayout ;
    

    
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



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%ld",(long)indexPath.row);
    //NSLog(@"%@",((XRImage *)self.picImageArr[indexPath.row]));
    MeiziCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //NSLog(@"%@",self.meiziArray[indexPath.row])  ;
    //[cell setMeizi:self.meiziArray[indexPath.row]];
    cell.imageView.image = ((XRImage *)self.picImageArr[indexPath.row]).image;
    //[cell setimageurl:((XRImage *)self.picImageArr[indexPath.row]).imageUrl];
    // 注：非常关键的一句，由于cell的复用，imageView的frame可能和cell对不上，需要重新设置。
    cell.imageView.frame = cell.bounds;
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
   
}

// UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    currentTouchIndexPath = indexPath;
    [self B_showWithTouchIndexPath:indexPath];
    
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
            //NSLog(@"%@",((Result*)gank.results[0]).url);
            if (page == 1) {
                [self.meiziArray removeAllObjects];
                [self.picImageArr removeAllObjects];
            }
            
            [self.meiziArray addObjectsFromArray:gank.results];//= [NSMutableArray arrayWithArray:gank.results];
            
            
            for (int i = ((int)page*20)-20 ; i< self.meiziArray.count ; i++) {
                
                
                //[SDWebImageManager sharedManager]ima
                XRImage * xrimage = [[XRImage alloc]init];
                
                if ([((Result *)self.meiziArray[i]).url containsString:@"jpg"]||[((Result *)self.meiziArray[i]).url containsString:@"jpeg"]) {
                    xrimage.imageUrl = [NSURL URLWithString:((Result *)self.meiziArray[i]).url];
                } else {
                    xrimage.imageUrl = [NSURL URLWithString:@"http://wx4.sinaimg.cn/bmiddle/d8203382ly1fslhcbkj1jj21281w0dwq.jpg"];
                }
                
                
                //[[SDWebImageManager sharedManager].imageDownloader setValue: nil forHTTPHeaderField:@"Accept"];
                [[SDWebImageManager sharedManager] loadImageWithURL:xrimage.imageUrl options:SDWebImageAllowInvalidSSLCertificates progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                    
                } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                    NSLog(@"errrrrror%@",error);
                    
                    
                    if(image){
                        
                        xrimage.imageW = image.size.width;
                        xrimage.imageH = image.size.height;
                        xrimage.image = image;
                        //NSLog(@"%@",xrimage.imageUrl);
                        
                        [self.picImageArr addObject:xrimage];
                        //NSLog(@"图片的数量%ld",self.picImageArr.count);
                        //[self.collectionView reloadData];
                    }
                    if(self.picImageArr.count  == self.meiziArray.count){
                        
                        [self.collectionView reloadData];
                        [self.collectionView.mj_header endRefreshing];
                        [self.collectionView.mj_footer endRefreshing];
                        return ;
                    }
                }];
                    
                
            }
        }else {
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
        // 请求成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        [self.collectionView.mj_header endRefreshing];
        
    }];
    //NSLog(@"%@",gank);
    
    
    
}


#pragma mark 刷新调用的方法
-(void)refreshMeizi{
    self.page = 1;
    
    [self getMeiziArray:self.page];
}
#pragma mark 加载更多调用的方法
-(void)loadMoreMeizi{
    self.page++;
    [self getMeiziArray:self.page];
    NSLog(@"几页了%ld",(long)self.page);
    
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

- (CGFloat)getImageRatioOfWidthAndHeight:(NSIndexPath *)indexPath
{   //NSLog(@"%@",self.picImageArr[indexPath.row]);
    CGFloat ratio = ((XRImage *)self.picImageArr[indexPath.row]).imageW/((XRImage *)self.picImageArr[indexPath.row]).imageH;
    return ratio;
}


#pragma mark 方式二、使用代理配置数据源

- (void)B_showWithTouchIndexPath:(NSIndexPath *)indexPath {
    
    //创建图片浏览器（注意：更多功能请看 YBImageBrowser.h 文件或者 github readme）
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSource = self;
    browser.currentIndex = indexPath.row;
    
    //展示
    [browser show];
}

//YBImageBrowserDataSource 代理实现赋值数据
- (NSInteger)numberInYBImageBrowser:(YBImageBrowser *)imageBrowser {
    return self.meiziArray.count;
}
- (YBImageBrowserModel *)yBImageBrowser:(YBImageBrowser *)imageBrowser modelForCellAtIndex:(NSInteger)index {
    YBImageBrowserModel *model = [YBImageBrowserModel new];
    model.url = ((XRImage *)self.picImageArr[index]).imageUrl;
    model.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return model;
}
- (UIImageView *)imageViewOfTouchForImageBrowser:(YBImageBrowser *)imageBrowser {
    return [self getImageViewOfCellByIndexPath:currentTouchIndexPath];
}

// tool
- (UIImageView *)getImageViewOfCellByIndexPath:(NSIndexPath *)indexPath {
    MeiziCell *cell = (MeiziCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (!cell) return nil;
    return cell.imageView;
}


@end
