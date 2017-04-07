# dotfiles(public)

## 开始

1. 初始设置，只需一次
```
curl -Lks https://cdn.rawgit.com/cyio/eb0786308145ef3af61c8fa334114ed4/raw/f309eae1da5f2604525049bfb4a7c23c098ba57e/dotfiles-init.sh | /bin/bash
```
2. 安装到新机器
```
curl -Lks https://cdn.rawgit.com/cyio/eb0786308145ef3af61c8fa334114ed4/raw/11f0430c3c1be65166ea4ab1ea68f121bd6debcf/dotfiles-install.sh | /bin/bash
```

(注意如果更新了脚本，可能要手动更新地址)

## 解释

* master 分支为共享配置，只有共享配置需要调整时才会检出并修改
* linux/macos 等分支在不同系统上使用，继承 master 分支并按需定制，应定期合并 master 分支的变化
* 安装脚本会设置 git 命令别名为 dotfiles，在 Home 目录下使用
* 添加文件时指定路径，而不要`dotfiles add -A`
```
cd ~
dotfiles pull
dotfiles checkout master/linux/macos
```

## 其他

`ls -a` 查看隐藏文件


(方法来自 [The best way to store your dotfiles: A bare Git repository - Atlassian Developers](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-re))
