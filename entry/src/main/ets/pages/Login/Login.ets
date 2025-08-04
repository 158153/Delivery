import { AccountFormModel } from '../../models/Index'
//1.给按钮绑定点击事件
//2.定义保存账号和密码变量
//3.将变量与输入框进行绑定

@Entry
@Component
struct Login {

  // 控制loading
  @State showLoading: boolean = false
  // 账号与密码
  @State
  accountForm :AccountFormModel ={
    account:'',
    password :''
  }



  //登录方法,点击登录按钮触发
  submitLogin(){

    // 显示加载loading
    this.showLoading = true
    AlertDialog.show({
      message:JSON.stringify(this.accountForm)
    })
  }
  // 账号与密码非空状态处理
  getFormValidate() {
    // 如果账号与密码都不为空,则返回true
    if (this.accountForm.account && this.accountForm.password) {
      return true
    }
    // 只要有一个为空,则返回false
    return false
  }



  //代码复用
  @Styles loginStyle(){
    .backgroundColor('#eefafafa')
    .height(58)
    .borderRadius(0)
    .border({
      width:{
        bottom:1
      },
      color:'#ff987f7f'
    })


  }

  build() {
    Column(){
 //标题
      Text('小时达')
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
 //账号登录标题
      Row(){
        Text('账号登录')
          .fontWeight(FontWeight.Bold)
          .fontSize(24)

        Row(){
          Text('手机号登录')
            .fontColor('#9ff30d0d')
          Image($r('app.media.login1'))
            .margin(5)
            .width(15)
            .height(15)
        }
      }.justifyContent(FlexAlign.SpaceBetween)
      .padding(20)
      .width('100%')
      .margin({
        top:20 ,bottom:20})

//账号输入框
      TextInput({placeholder:"请输入账号",text:$$this.accountForm.account})
        .loginStyle()

//密码输入框
      TextInput({placeholder:"请输入密码",text:$$this.accountForm.password})
        .type(InputType.Password)
        .loginStyle()


//登录按钮
      Button({type :ButtonType.Capsule}){
        Row() {
          if (this.showLoading) {
            LoadingProgress()
              .width(20)
              .height(20)
              .color('#00393838')
              .margin({
                right: 12
              })
          }

          Text("登录")
            .fontColor("#c13c3b3b")
        }

      }.width('100%')
      .height(50)
      .backgroundColor(this.getFormValidate() ? '#ffe21818' :'#fff5b3b3')
      .fontColor(Color.White)
      .margin({
        top:50 })
      .enabled(this.getFormValidate())
      .onClick(()=>{

      })

    }
    .padding(10)
    .height('100%')
    .width('100%')

  }
}