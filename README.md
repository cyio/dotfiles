# dotfiles

## 开始

初始设置，只需一次
```
curl -Lks https://cdn.rawgit.com/cyio/eb0786308145ef3af61c8fa334114ed4/raw/f309eae1da5f2604525049bfb4a7c23c098ba57e/dotfiles-init.sh | /bin/bash
```
安装到新机器
```
curl -Lks https://cdn.rawgit.com/cyio/eb0786308145ef3af61c8fa334114ed4/raw/11f0430c3c1be65166ea4ab1ea68f121bd6debcf/dotfiles-install.sh | /bin/bash
```

注意如果更新了脚本，可能要手动更新地址

## 日常使用

master 分支为共享配置
linux/macos 等分支是在 master 分支基础上定制而来
一般在机器上不使用 master 分支，只有共享配置需要调整才会修改，修改后要在各个系统分支上合并
```
# example: current branch is linux
dotfiles checkout master
# do something
# commit then push
dotfiles checkout linux
dotfiles merge master
```

## 其他

`ls -a` 查看隐藏文件


(方法来自 [The best way to store your dotfiles: A bare Git repository - Atlassian Developers](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-re))
