
/********************************************************************************
 ********************************************************************************
 http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000
 
 1.创建版本库
 新建一个文件夹，起个名字，在terminal中执行cd到这个文件夹，并执行 git init来指定它为代码仓库，可以用  ls -ah  来查看有没有隐藏的.git文件被生成了，有就成功了。
 
 2.加文件
 把要加的文件放在新建的文件夹里，在terminal中执行git add <fileName1> <fileName2>后（没有反应），再用git status 查看有哪些更改，再git commit -m “注释”,再git status查看还有没有更新的。
 git log -1 可以显示最近一次的提交
 
 3.git修改提交的用户名和Email
 git config --global user.name "dingzhiwen"
 git config --global user.email dingzhiwen@buding.cn
 全局的通过vim ~/.gitconfig来查看
 git config user.name "Your Name"
 git config user.email you@example.com
 局部的通过当前路径下的 .git/config文件来查看
 也可以修改提交的用户名和Email：
 git commit --amend --author='Your Name <you@example.com>'
 
 4.git log查看日志 太多数据可以加上 --pretty=oneline(一行显示一项提交)
 
 5.当前版本 HEAD^
 Git必须知道当前版本是哪个版本，在Git中，用HEAD表示当前版本，也就是最新的提交3628164...882e1e0（注意我的提交ID和你的肯定不一样），上一个版本就是HEAD^，上上一个版本就是HEAD^^，当然往上100个版本写100个^比较容易数不过来，所以写成HEAD~100
 
 6.回退版本 git reset
 git reset --hard HEAD^
 
 如果继续回退到上一个版本
 1)只要上面的命令行窗口还没有被关掉，你就可以顺着往上找啊找啊，找到那个的id,比如是:3628164,执行git reset --hard 3628164就可以了，版本号没必要写全，前几位就可以了，Git会自动去找。当然也不能只写前一两位，因为Git可能会找到多个版本号，就无法确定是哪一个了。
 2)关掉了窗口。Git提供了一个命令git reflog用来记录你的每一次命令：
 
 7.撤销修改
 git checkout -- <fileName>
 这里有两种情况：
 1)一种是file自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
 2)一种是file已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。
 @)总之，就是让这个文件回到最近一次git commit或git add时的状态。
 
 8.撤销add过的文件修改
 git reset HEAD <fileName>
 
 9.文件名的空格问题
 首先尽量不要带空格，如果有空格，用abc\ xyz试试
 
 10.删除文件
 本地工作区删除先，再用命令git rm删掉，并且git commit
 删错了git checkout -- <fileName>
 
 11.远程仓库
 1)可以选择用github的，不过要弄成私有的，得收费。
 a)注册了账号后，创建和添加SSH Key，新建一个Repository
 b)用git remote add origin <地址>   关联本地的仓库
 c)输入github的用户名和密码
 d)git push -u origin master 把本地库的所有内容推送到远程库上
 把本地库的内容推送到远程，用git push命令，实际上是把当前分支master推送到远程。
 由于远程库是空的，我们第一次推送master分支时，加上了-u参数，Git不但会把本地的master分支内容推送的远程新的master分支，还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令。
 e)从此，只要本地作了提交，就可以通过命令：git push origin master 把本地master分支的最新修改推送至GitHub，现在，你就拥有了真正的分布式版本库！
 f)设置推送分支为当前分支：git config --global push.default current
 
 2)也可以自己搭建
 
 
 12.SSH警告 当你第一次使用Git的clone或者push命令连接GitHub时，会得到一个警告：输入yes回车即可.
 
 13.从远程库克隆 git clone <git地址>
 1)Git支持多种协议，包括https，但通过ssh支持的原生git协议速度最快。使用https除了速度慢以外，还有个最大的麻烦是每次推送都必须输入口令，但是在某些只开放http端口的公司内部就无法使用ssh协议而只能用https
 2)查看远程库的信息，用git remote
 3)git remote -v显示更详细的信息,如果没有推送权限，就看不到push的地址
 
 14.分支管理
 1)创建分支 git checkout -b <分支名字>
   git checkout命令加上-b参数表示创建并切换，相当于以下两条命令:
   git branch <分支名字>
   git checkout <分支名字>
 2)git branch命令查看当前分支 带*的为当前分支
 3)合并分支 
 a)git merge [--no-ff] [-m <"说明">] <指定的分支名> 命令用于合并指定分支到当前分支
 b)Fast-forward信息告诉我们，这次合并是“快进模式”，也就是直接把master指向dev的当前提交，所以合并速度非常快，当然，也不是每次合并都能Fast-forward，我们后面会将其他方式的合并。
 c)--no-ff参数(分支名字写在最后)，表示禁用Fast forward.要强制禁用Fast forward模式，Git就会在merge时生成一个新的commit
 d)要合并创建的新的commit，可以加上-m <"说明">参数(分支名字写在最后)
 4)删除分支
 a)删除(未合并的不能被删除成功):git branch -d <分支名>
 b)强行删除:git branch -D <分支名>
 
 15.解决冲突
 a)合并分支后可能出现冲突的情况，需要手动解决冲突后再提交，之后可以用git log --graph命令查看分支合并图
 b)git log --graph --pretty=oneline --abbrev-commit 查看分支
 
 16.Bug分支
 Git还提供了一个stash功能，可以把当前工作现场“储藏”起来，等以后恢复现场后继续工作:git stash
 修复完Bug再回来继续：git stash list命令查看工作现场
 1)用git stash apply恢复，但是恢复后，stash内容并不删除，你需要用git stash drop来删除
 2)另一种方式是用git stash pop，恢复的同时把stash内容也删了
 
 17.推送分支
 git push origin <分支名>
 
 18.抓取分支
 git pull，如果git pull失败了，原因是没有指定本地分支与远程origin/分支的链接，执行命令：git branch --set-upstream <本地分支名> origin/<远程分支名>
 
 19.标签管理
 标签跟分支类似，但是分支可以移动，标签不能移动，创建和删除标签都是瞬间完成的。
 1)创建标签,创建的标签都只存储在本地 git tag <标签名>
 2)查看标签 git tag
 3)默认标签是打在最新提交的commit上的。如果忘了打标签可以找到历史提交的commit id，然后打上就可以了
 git tag <标签名> <id>
 4)标签是按字母排序的。可以用git show <标签名>查看标签信息
 5)创建带有说明的标签，用-a指定标签名，-m指定说明文字:git tag -a v0.1 -m "read" 3628164
 6)通过-s用私钥签名一个标签,必须首先安装gpg（GnuPG），如果没有找到gpg，或者没有gpg密钥对，就会报错,参考GnuPG帮助文档配置Key.
 7)删除标签 git tag -d <标签名>
 8)推送某个标签到远程 git push origin <标签名>
 9)一次性推送全部尚未推送到远程的本地标签 git push origin --tags
 10)删除远程标签
 a)先删除本地 git tag -d <标签名>，再删除远程的 git push origin :refs/tags/<标签名>
 
 20.GitHub忽略特殊文件
 .gitignore文件,配置文件可以直接在线浏览：https://github.com/github/gitignore,自己组合即可，
 .gitignore文件本身要放到版本库里，并且可以对.gitignore做版本管理
 
 21.配置别名
 1)git config --global alias.st status  --> 之后st就表示status了
 2)甚至还有人丧心病狂地把lg配置成了：
 git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
 3)配置文件在.git/config文件中,别名也在里面哦，[alias]后面，删除对应行即可删除别名
 4)配置别名也可以直接修改这个文件，如果改错了，可以删掉文件重新通过命令配置
 
 21.ssh key
 1)查看是否已经有了ssh密钥：cd ~/.ssh
 2)生成密钥：ssh-keygen -t rsa -C “dingzhiwen@buding.cn”
 3)测试：ssh git@github.com
 4)

*********************************************************************************
*********************************************************************************/