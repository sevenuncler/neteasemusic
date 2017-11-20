//
//  SUUserItem.h
//  ReactiveCocoaProj
//
//  Created by fanghe on 17/11/19.
//  Copyright © 2017年 sevenuncle. All rights reserved.
//

#import "SUItem.h"

@interface SUUserItem : SUItem

@property(nonatomic, assign) BOOL       defaultAvatar;
@property(nonatomic,assign) NSInteger   province; //"province": 110000,
@property(nonatomic,assign) NSInteger   authStatus;//"authStatus": 0,
@property(nonatomic,assign) BOOL        followed;//"followed": false,
@property(nonatomic,copy)   NSString    *avatarUrl;//"avatarUrl": "http://p1.music.126.net/fraq_2_kxZc2VzsZdZtBOQ==/3284241235740630.jpg",
@property(nonatomic,assign) NSInteger   accountStatus;//"accountStatus": 0,
@property(nonatomic,assign) NSInteger   gender;//"gender": 2,
@property(nonatomic,assign) NSInteger   city;//"city": 110101,
@property(nonatomic,copy)   NSString    *birthday;//"birthday": -1510300800000,
@property(nonatomic,copy)   NSString    *userId;//"userId": 19299028,
@property(nonatomic,assign) NSInteger   userType;//"userType": 0,
@property(nonatomic,copy)   NSString    *nickname;//"nickname": "螺丝起子",
@property(nonatomic,copy)   NSString    *signature;//"signature": "想要做张好单，奈何思路经常便秘…",
@property(nonatomic,copy)   NSString    *desc;//"description": "",
@property(nonatomic,copy)   NSString    *detailDescription;//"detailDescription": "",
@property(nonatomic,assign) NSInteger   avatarImgId;//"avatarImgId": 3284241235740630,
@property(nonatomic,assign) NSInteger   backgroundImgId;//"backgroundImgId": 18582846021338481,
@property(nonatomic,copy)   NSString    *backgroundUrl;//"backgroundUrl": "http://p1.music.126.net/esdZCGXCS3WLndUCWkKq8g==/18582846021338481.jpg",
@property(nonatomic,assign) NSInteger   authority;//"authority": 0,
@property(nonatomic,assign) BOOL        mutual;//"mutual": false,
@property(nonatomic,copy)   NSArray     *expertTags;//"expertTags": [
//               "流行",
//               "欧美",
//               "影视原声"
//               ],
@property(nonatomic,copy)   NSArray     *experts;//"experts": null,
@property(nonatomic,assign) NSInteger   djStatus;//"djStatus": 10,
@property(nonatomic,assign) NSInteger   vipType;//"vipType": 10,
@property(nonatomic,copy)   NSString    *remarkName;//"remarkName": null,
@property(nonatomic,copy)   NSString    *avatarImgIdStr;//"avatarImgIdStr": "3284241235740630",
@property(nonatomic,copy)   NSString    *backgroundImgIdStr;//"backgroundImgIdStr": "18582846021338481"
@end
