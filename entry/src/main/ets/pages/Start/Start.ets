import  { AdvertClass } from 'basic'
@Entry
@Component
struct Start {

//状态变量
  @State
  adObj : AdvertClass = {
    showAd : false,
    adTime :5
  }
  @State
  timer : number=-1


//页面开始加载时候就会触发方法
  aboutToAppear(): void {
  //调用倒计时方法
    this.countDown()
  }

//倒计时的方法
  countDown(){
    this.timer=setInterval(() =>{
      if (this.adObj.adTime===0 ) {
        clearInterval(this.timer)
        return
      }
      this.adObj.adTime--
    },1000)
  }
//当前页面销毁的时候一定要清除定时器，如果不清楚，内存会泄露
  aboutToDisappear(): void {
    //清楚定时器
    clearInterval(this.timer)
  }



  build() {
    //让文字显示在图片的右上角
    Stack({alignContent:Alignment.TopEnd}){
      Image($r("app.media.guanggao1"))
        .objectFit(ImageFit.Cover)//广告图片充满屏幕
      //定时跳过
      Text(this.adObj.adTime+'秒后跳过')
        .backgroundColor('#ffcfcece')
        .padding({left:10,right:10})
        .height(30)
        .borderRadius(15)
        .fontSize(14)
        .textAlign(TextAlign.Center)
        .margin({right:20,top:20})


    }
    .height('100%')
    .width('100%')

  }
}