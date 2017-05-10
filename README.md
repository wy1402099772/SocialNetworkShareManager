###SocialNetworkShareManager
## Share Image to SocialWork such as Instagram, FB, Twitter...


1. add Scheme, Instagram, fb, fbauth...
2. NSPhotoLibraryUsageDescription in Info.plist

```
在 Xcode 中，使用辅键点击项目的 .plist 文件并选择 Open As（打开方式）-> Source Code（源代码）。
将以下 XML 代码片段插入文件正文，位于最后的 </dict> 元素前。

<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>fb{your-app-id}</string>
    </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>{your-app-id}</string>
<key>FacebookDisplayName</key>
<string>{your-app-name}</string>
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>fbapi</string>
  <string>fb-messenger-api</string>
  <string>fbauth2</string>
  <string>fbshareextension</string>
</array>
<key>NSPhotoLibraryUsageDescription</key>
  <string>{human-readable reason for photo access}</string>
将 fb{your-app-id} 替换为 Facebook 应用编号，加上前缀 fb。例如，fb123456。您可以通过 Facebook 应用面板找到应用编号。
使用应用编号替换 {your-app-id}。
使用您在应用面板中指定的显示名称替换 {your-app-name}。
将 {human-readable reason for photo access} 替换为您的应用需要获取照片访问权限的理由

```
