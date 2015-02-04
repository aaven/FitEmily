//
//  FYWeChatNetwork.m
//  FitEmily
//
//  Created by Fiona Yang on 2/4/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import "FYWeChatNetwork.h"
#import "Define.h"

@implementation FYWeChatNetwork

+ (FYWeChatNetwork *)sharedManager {
    static dispatch_once_t pred;
    static FYWeChatNetwork *singleton = nil;
    dispatch_once(&pred, ^{
        singleton = [[FYWeChatNetwork alloc] init];
    });
    return singleton;
}

- (void)loginButtonClicked {
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo";
    req.state = AppDescription;
    [WXApi sendReq:req];
}

- (void)getWeiXinCodeFinishedWithResp:(BaseResp *)resp {
    if (resp.errCode == 0) {
        _FYWeChatInfoVC.statusCodeLabel.text = @"用户同意";
        SendAuthResp *aresp = (SendAuthResp *)resp;
        [self getAccessTokenWithCode:aresp.code];
    } else if (resp.errCode == -4) {
        _FYWeChatInfoVC.statusCodeLabel.text = @"用户拒绝";
    }else if (resp.errCode == -2) {
        _FYWeChatInfoVC.statusCodeLabel.text = @"用户取消";
    }
}

- (void)getAccessTokenWithCode:(NSString *)code {
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WeiXinAppId,WeiXinAppSecret,code];
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                if ([dict objectForKey:@"errcode"])
                {
                    //获取token错误
                }else{
                    //存储AccessToken OpenId RefreshToken以便下次直接登陆
                    //AccessToken有效期两小时，RefreshToken有效期三十天
                    [self getUserInfoWithAccessToken:[dict objectForKey:@"access_token"] andOpenId:[dict objectForKey:@"openid"]];
                }
            }
        });
    });
    
    /*
     正确返回
     "access_token" = “Oez*****8Q";
     "expires_in" = 7200;
     openid = ooVLKjppt7****p5cI;
     "refresh_token" = “Oez*****smAM-g";
     scope = "snsapi_userinfo";
     */
    
    /*
     错误返回
     errcode = 40029;
     errmsg = "invalid code";
     */
}

- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId {
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data)
            {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                if ([dict objectForKey:@"errcode"])
                {
                    //AccessToken失效
                    [self getAccessTokenWithRefreshToken:[[NSUserDefaults standardUserDefaults]objectForKey:WeiXinRefreshToken]];
                }else{
                    //获取需要的数据
                }
            }
        });
    });
    
    /*
     city = ****;
     country = CN;
     headimgurl = "http://wx.qlogo.cn/mmopen/q9UTH59ty0K1PRvIQkyydYMia4xN3gib2m2FGh0tiaMZrPS9t4yPJFKedOt5gDFUvM6GusdNGWOJVEqGcSsZjdQGKYm9gr60hibd/0";
     language = "zh_CN";
     nickname = “****";
     openid = oo*********;
     privilege =     (
     );
     province = *****;
     sex = 1;
     unionid = “o7VbZjg***JrExs";
     */
    
    /*
     43      错误代码
     44      errcode = 42001;
     45      errmsg = "access_token expired";
     46      */
}

- (void)getAccessTokenWithRefreshToken:(NSString *)refreshToken {
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",WeiXinAppId,refreshToken];
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (data)
            {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                if ([dict objectForKey:@"errcode"])
                {
                    //授权过期
                }else{
                    //重新使用AccessToken获取信息
                }
            }
        });
    });
    
    
    /*
     "access_token" = “Oez****5tXA";
     "expires_in" = 7200;
     openid = ooV****p5cI;
     "refresh_token" = “Oez****QNFLcA";
     scope = "snsapi_userinfo,";
     */
    
    /*
     错误代码
     "errcode":40030,
     "errmsg":"invalid refresh_token"
     */
}
@end
