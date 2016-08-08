//
//  ACCVC.m
//  DummyAccessibility
//
//  Created by Melaniia Hulianovych on 8/5/16.
//  Copyright © 2016 Melaniia Hulianovych. All rights reserved.
//

#import "ACCVC.h"
#import "TableViewLiveSectionGridCell.h"
#import "GridViewGeneralCellContentView.h"
#import "Item.h"

@interface ACCVC ()<UITableViewDelegate, UITableViewDataSource> {
 NSMutableArray *_tableViewCells;
 NSMutableArray *_datasource;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchControll;

@end

@implementation ACCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableViewCells = [[NSMutableArray alloc]initWithCapacity:2];
    _datasource = [[NSMutableArray alloc]init];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    NSArray *imageArray = [[NSMutableArray alloc]initWithObjects:
                            @"https://static.pexels.com/photos/1848/nature-sunny-red-flowers.jpg",
                            @"http://all4desktop.com/data_images/original/4249535-raven.jpg",
                            @"http://all4desktop.com/data_images/original/4249168-horse.jpg",
                            @"http://all4desktop.com/data_images/original/4140623-fire-beach.jpg",
                            @"http://all4desktop.com/data_images/original/4140642-white-horse.jpg",
                            @"http://all4desktop.com/data_images/original/4140648-crisis.jpg",
                            @"http://all4desktop.com/data_images/original/4140581-nature-sail.jpg",
                            @"http://all4desktop.com/data_images/original/4140660-nfs-rivals.jpg",
                            @"http://all4desktop.com/data_images/original/4140669-far-cry-4-dead-tiger.jpg",
                            @"http://all4desktop.com/data_images/original/4140606-lake-louise-reflections.jpg",
                            @"http://all4desktop.com/data_images/original/4140722-wooden-path.jpg",
                            @"http://all4desktop.com/data_images/original/4140678-icelands-ring-road.jpg",
                            @"http://all4desktop.com/data_images/original/4140765-diver-and-the-mermaid.jpg",
                            @"http://all4desktop.com/data_images/original/4140745-denali-national-park.jpg",
                            @"http://all4desktop.com/data_images/original/4140827-hiro-in-big-hero-6.jpg",
                            @"http://all4desktop.com/data_images/original/4140837-eagle-effect-HD.jpg",
                            @"http://all4desktop.com/data_images/original/4140844-trine-underwater-scene.jpg",
                            @"http://all4desktop.com/data_images/original/4137380-dragon-mountains.jpg",
                            @"http://all4desktop.com/data_images/original/4137353-sunrise-joy.jpg",
                            @"http://all4desktop.com/data_images/original/4137364-good-morning-coffee.jpg",
                            @"http://all4desktop.com/data_images/original/4137345-norway-aviation.jpg",
                            @"http://all4desktop.com/data_images/original/4137391-floating-rainbow-island.jpg",
                            @"http://all4desktop.com/data_images/original/4137428-spring-sunflower.jpg",
                            @"http://all4desktop.com/data_images/original/4137435-sci-fi-twilight.jpg",
                            @"http://all4desktop.com/data_images/original/4137441-gta-5-street-fight.jpg",
                            @"http://all4desktop.com/data_images/original/4137447-tom-clancys-the-division.jpg",
                            @"http://all4desktop.com/data_images/original/4137469-the-legend-of-zelda-ocarina-of-time.jpg",
                            @"http://all4desktop.com/data_images/original/4137479-sunset-maui-hawaiian-island.jpg",
                            nil];
    NSArray *accessibilityArray = @[@"Flowers", @"Raven", @"Horse", @"Fire beach", @"White horse", @"Crisis", @"Nature sail", @"Rivals", @"Dead Tiger", @"Lake louise reflections", @"Wooden path", @"icelands", @"diver",@"denali", @"hero",@"eagle", @"trine",@"dragon", @"sunrise"];
    for(int i=0; i<19; i++) {
        Item *item = [[Item alloc]init];
        item.imageLink = imageArray[i];
        item.textLabel = accessibilityArray[i];
        [_datasource addObject:item];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 196.;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    TableViewLiveSectionGridCell *cell;
    if([_tableViewCells count] == 2) {
     cell = _tableViewCells[indexPath.section];
    }
        if (!cell)
        {
            cell = [[TableViewLiveSectionGridCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil withArray:_datasource];
            _tableViewCells[indexPath.section] = cell;
            
            ((TableViewLiveSectionGridCell *)cell).navigationController = self.navigationController;
        }
        
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
