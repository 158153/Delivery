//广告页面

import  { AdvertClass, UserSettingClass } from 'basic'
import { window } from '@kit.ArkUI'

@Entry
@Component
struct Start {

//状态变量
  @State
  adObj : AdvertClass = {} as AdvertClass
  @State
  timer : number=-1


//页面开始加载时候就会触发方法
  aboutToAppear(): void {
    // 获取本地存储的广告配置
    const setting = new UserSettingClass(getContext())
    this.adObj=setting.getUserAd()
    //调用倒计时方法
    this.countDown()
  }
//销毁子窗口的方法
  closeWin(){
    //1.查找销毁的窗口
    //2.进行销毁
    window.findWindow("ad_window").destroyWindow()
  }

//倒计时的方法
  countDown(){
    //开启定时器
    this.timer=setInterval(() =>{
      //当倒计时为0的时候
      if (this.adObj.adTime===0 ) {
        //清除定时计数器
        clearInterval(this.timer)
        //销毁子窗口
        this.closeWin()
        //组织代码继续进行
        return
      }
      //倒计时减减
      this.adObj.adTime--
    },1000)
  }
//当前页面销毁的时候一定要清除定时器，如果不清楚，内存会泄露
  aboutToDisappear(): void {
    //清除定时器
    clearInterval(this.timer)
  }



  build() {
    //让文字显示在图片的右上角
    Stack({alignContent:Alignment.TopEnd}){
      Image($r("app.media.guanggao1"))
        .objectFit(ImageFit.Cover)//广告图片充满屏幕
      //定时跳过
      Text(this.adObj.adTime===0 ?"跳过" :this.adObj.adTime+'秒后跳过')
        .backgroundColor('#ffcfcece')
        .padding({left:10,right:10})
        .height(30)
        .borderRadius(15)
        .fontSize(14)
        .textAlign(TextAlign.Center)
        .margin({right:20,top:20})
        .onClick(() => {
          this.closeWin()
        })


    }
    .height('100%')
    .width('100%')

  }
}