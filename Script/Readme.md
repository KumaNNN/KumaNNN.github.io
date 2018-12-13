# Script 目录配置说明

### 目录列表

```
Script
├─hook
│  │  pre-commit
│  │  
│  └─SubRepo
│          post-commit
│          
└─sh
    │  CallX.bat
    │  conf.bat
    │  Copy_public_git_To_public.bat
    │  info.bat
    │  init.bat
    │  ReadConf.bat
    │  repair_public_link.bat
    │  start.bat
    │  submodule.bat
    │  submodule_batch.bat
    │  write_copy_status.bat
    │  YAML
    │  YAMLwrite.bat
    │  
    └─git_submodule
        └─Template
                Template.add
                Template.bat
                Template.del
                Template.init
                Template.update
```



### 列表说明

* `hook`   ： git钩子根目录。
  * `pre-commit`  ： 父仓库使用的 ==预提交钩子(pre-commit)==  。
  * `SubRepo` ： 子仓库使用的钩子。
    * `post-commit` ： 提交钩子。



* `sh`  ： 脚本根目录(.bat：Windows专用)。
  * `init.bat` ： 子仓库初始化脚本。将此脚本和Script目录一起复制到子仓库根目录。
  * `CallX.bat`  ： 依赖文件，用于脚本之间的调用。
  * `conf.bat` ： 依赖文件，用于读取配置文件。
  * `Copy_public_git_To_public.bat`  ： 检出public数据库并复制到仓库根目录public下。
    * 可手动执行
  * `ReadConf.bat` ： 根据文件中的配置项进行目录和文件的复制(不包含隐藏文件夹)。
    * 父仓库，==预提交钩子(pre-commit)==  调用。
  * `write_copy_status.bat`  ：写入状态数据到特定文件。
    * 子模块(子仓库)，==提交钩子(post-commit)== 调用。
    * 将通过钩子复制到仓库根目录执行，执行完删除自身。
  * `info.bat`  :  仓库基本配置信息。
    * 可手动执行或被调用。
  * `submodule.bat`  :  依赖文件，用于处理子模块。
  * `submodule_batch.bat`  ： 根据配置文件批处理子模块，在父项目中。
    * 配置文件路径：` .git\myconf\submodule`
    * 在子仓库初始化时，会生成相关的配置文件，将其复制到`.git\myconf\submodule\staged` 下。
  * `repair_public_link.bat`  :  修复子模块 public 并检出自定义文件。
  * `YAMLwrite.bat` ： 输出md文件的YAML头。
  * `YAML` ： YAML模版。
  * `start.bat` ： 子仓库初始化启动器。可复制到根目录执行。
* `git_submodule`  ： git 子模块根目录。
  * `Template`  ： 模版目录。
    * `Template.bat` ：配置文件生成。



