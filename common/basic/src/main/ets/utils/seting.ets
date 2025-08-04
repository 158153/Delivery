import  { AdvertClass } from '../models/advert'
import  { XSD_SETTING ,XSD_SETTING_AD} from '../constants/setting'
//封装存储数据的方法
import { preferences } from "@kit.ArkData"
import { settings } from '@kit.BasicServicesKit'


//广告的默认配置(后台返回的广告配置}
export const  defaultAd:AdvertClass ={
  //广告的时长
  adTime : 10,
  //显示广告与否
  showAd : true,
  //广告图片
  adImage : $r("app.media.guanggao1")
}

// //将广告配置存储本地key提取为常量
// const xsd_setting = "setting"
// const xsd_setting_ad = "setting_ad"

export class UserSettingClass{
//初始化变量
  context : Context
    //实例化UserSettingClass这个类进行触发
  constructor(context : Context) {
    //初始化上下文对象
    this.context = context
  }

//首选项---->必须要有仓库

//创建仓库
  getStore(){
      //创建仓库
    return preferences.getPreferencesSync(this.context,{
      name : XSD_SETTING
    })
  }
//存储广告数据
  setUserAd(ad:AdvertClass ){
      //获取到了创建的仓库
    const store = this.getStore()
      //给仓库存储数据
    store.putSync(XSD_SETTING_AD,JSON.stringify(ad))
     //将数据写入到磁盘
    store.flush()
  }


//获取数据
  getUserAd():AdvertClass {
     //获取创建的仓库
    const store = this.getStore()
     //获取广告的数据
    return JSON.parse(store.getSync(XSD_SETTING_AD,JSON.stringify(defaultAd)) as string)
  }

}



