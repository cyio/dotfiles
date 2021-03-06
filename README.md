# dotfiles(public)

## 开始

1. 初始设置，只需一次
```
curl -Lks https://gist.githubusercontent.com/cyio/eb0786308145ef3af61c8fa334114ed4/raw/5e8d6b4402da3317ad935655448fa106dc107538/dotfiles-init.sh | /bin/bash
```

2. 安装到新机器
(最好先装这个，再装 zsh 和 oh-my-zsh，或者在装之前把`.zshrc`文件删掉)

```
curl -Lks https://gist.githubusercontent.com/cyio/eb0786308145ef3af61c8fa334114ed4/raw/5e8d6b4402da3317ad935655448fa106dc107538/dotfiles-install.sh | /bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ~/.vim
ln -s ~/UltiSnips ./UltiSnips

cd ~/.vim/plugged/tern_for_vim
yarn
```

(注意如果更新了脚本，可能要手动更新地址)
注意查看 worknotes -> dev-setup.md，有很多需要注意的地方

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

## 冲突解决

平时总是在 linux/macos 分支下，如果做了修改，怎么合并给 master？
先撤销分支本身的特殊修改，stash，再切到 master 下 stash apply

有个别文件少量改动，但又不提交，不能切换分支怎么办？可以手动复制一份，撤销这个文件，等合并完回来再恢复

## 其他

`ls -a` 查看隐藏文件


(方法来自 [The best way to store your dotfiles: A bare Git repository - Atlassian Developers](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-re))
