# Otofuda-iOS

## Getting Started

1. CocoaPodをインストールしてください。
```
pod install
```

2. Carthageをインストールしてください。
```
carthage update --platform iOS
```

3. 下記URLから `GoogleService-Info.plist` を追加してください

[Firebase/Settings](https://console.firebase.google.com/project/otofuda-a41cc/settings/general/ios:nkmr-lab.Otofuda-iOS)

## Branchs
- `master` リリースするタイミングでマージする
- `develop` 各機能が完成したらマージする
- `features/xxxx(機能名)` 機能ごとでブランチを分ける

## Installing

### Carthage
- Alamofire/Alamofire
- Alamofire/AlamofireImage
- SwiftyJSON/SwiftyJSON
- mxcl/PromiseKit
- Hearst-DD/ObjectMapper

### Pods
- Firebase
- Firebase/Database
