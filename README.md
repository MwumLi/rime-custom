## 安装 rime-install

参见 <https://github.com/rime/plum>  

```
curl -fsSL https://raw.githubusercontent.com/rime/plum/master/rime-install > rime-install
```

## 小鹤双拼

双拼方案：<https://github.com/rime/rime-double-pinyin>  

首先安装小鹤双拼的 schema 文件：  

``` bash
bash rime-install double-pinyin
```

在 `default.custom.yaml` 中 schema_list 添加 `double_pinyin_flypy`  

自定义行为在 `double_pinyin_flypy.custom.yaml` 中配置。

## emoji

emoji 方案：<https://github.com/rime/rime-emoji>  

命令安装：`bash rime-install emoji`  

配制参考 <https://github.com/rime/rime-emoji/blob/master/emoji_suggestion.yaml>  


