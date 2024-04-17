const versions = [
    'node-v10.9.0-win-x64',
    'node-v12.22.7-win-x64',
    'node-v14.9.0-win-x64',
    'node-v14.21.3-win-x64',
    'node-v16.20.2-win-x64',
    'node-v18.16.0-win-x64'
]
// echo %Path%
const path = 'C:\\Program Files\\Common Files\\Oracle\\Java\\javapath;C:\\Program Files (x86)\\Common Files\\Oracle\\Java\\javapath;D:\\wzlPro\\nTrun_V3.1.1\\Goto;C:\\Windows\\system32;C:\\Windows;C:\\Windows\\System32\\Wbem;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\;C:\\WINDOWS\\system32;C:\\WINDOWS;C:\\WINDOWS\\System32\\Wbem;C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\;C:\\WINDOWS\\System32\\OpenSSH\\;D:\\wzlPro\\GitExtensions\\;C:\\Program Files\\dotnet\\;C:\\Program Files (x86)\\dotnet\\;C:\\Program Files\\Go\\bin;C:\\Program Files\\Git\\cmd;F:\\apache-maven-3.6.3\\bin;F:\\mongodb-win32-x86_64-2012plus-4.2.7\\bin\\;D:\\wzlPro\\Microsoft VS Code\\bin;D:\\mysql\\bin;D:\\python\\Scripts;C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\WindowsApps;S:\\android-sdk-windows\\platform-tools;D:\\node-v14.21.3-win-x64;C:\\Program Files\\Java\\jdk1.8.0_281\\bin;C:\\Program Files\\Java\\jdk1.8.0_281\\jre\\bin;C:\\Users\\Administrator\\go\\bin;C:\\Users\\Administrator\\AppData\\Local\\JetBrains\\Toolbox\\scripts;D:\\wzlPro\\Fiddler;D:\\wzlPro\\MarkdownMonsterPortable;D:\\Python2;C:\\Users\\Administrator\\.dotnet\\tools;';

console.log(path)
// D:\node-v16.13.1-win-x64;
console.log('set PATH=' +  path.replace(/node-v[\d\\.]*-win-x64/g, versions[1]))
// set PATH=C:\Program Files\Common Files\Oracle\Java\javapath;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;D:\wzlPro\nTrun_V3.1.1\Goto;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;D:\wzlPro\GitExtensions\;C:\Program Files\dotnet\;C:\Program Files (x86)\dotnet\;F:\微信web开发者工具\dll;ram Fi;es (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Go\bin;C:\Program Files\Git\cmd;F:\apache-maven-3.6.3\bin;F:\mongodb-win32-x86_64-2012plus-4.2.7\bin\;D:\wzlPro\Microsoft VS Code\bin;D:\mysql\bin;D:\python\Scripts;C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;D:\python;E:\android-sdk-windows\platform-tools;D:\node-v12.22.7-win-x64;C:\Program Files\Java\jdk1.8.0_281\bin;C:\Program Files\Java\jdk1.8.0_281\jre\bin;C:\Users\Administrator\go\bin;C:\Users\Administrator\AppData\Local\JetBrains\Toolbox\scripts;D:\wzlPro\Fiddler;D:\wzlPro\MarkdownMonsterPortable
