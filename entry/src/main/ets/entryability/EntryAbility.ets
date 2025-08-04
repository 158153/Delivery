import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import {defaultAd, UserSettingClass} from 'basic';
import { AdvertClass} from 'basic';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

 async onWindowStageCreate(windowStage: window.WindowStage): Promise  <void> {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

//进入应用的时候，调用后台接口获取广告配置
   const ad = new Promise <AdvertClass>((resolve) => {
     setTimeout(()=>{
       resolve(defaultAd)
     },500)
   })

//将广告配置存储到本地
   const setting = new UserSettingClass(this.context)
       // 先 await 拿到 Promise 结果
   const adInstance = await ad;
       // 再调用 setUserAd，此时参数类型为 AdvertClass，匹配方法期望类型
   setting.setUserAd(adInstance)

//通过广告的配置来决定是否显示广告
   if ((await ad).showAd) {
       //创建子窗口,广告页面

     const win = await  windowStage.createSubWindow("ad_window")
       //显示子窗口
     await win.showWindow()
       //加载广告页面，加载ui内容
     win.setUIContent("pages/Start/Start")

   }






    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}