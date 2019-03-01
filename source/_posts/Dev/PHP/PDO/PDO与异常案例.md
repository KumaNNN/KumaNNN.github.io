---
title: PDO与异常案例
date: 2019-02-28 12:36:17
updated: 2019-02-28 12:36:17 
mathjax: false
categories: 
tags:
typora-root-url: PDO与异常案例
typora-copy-images-to: PDO与异常案例
top: 1
---



# PDO与异常



## 案例：封装PDO操作类

### 功能分析

1. 连库基本操作；
2. 设置操作（增删改）；
3. 查一条数据；
4. 查多条数据；



### 代码实现

构建名为code18.php的程序，代码如下，

```php
/**
 * PDO操作类
 * @param
 */
class PDOTool{

    private $type;//数据库的类型
    private $host;//IP地址
    private $port;//端口号
    private $charset;//字符集
    private $dbname;//默认选择的数据库
    private $acc;//帐号
    private $pwd;//密码

    private $pdo;

    public function __construct($type='mysql', $host='localhost', $port=3306, $charset='utf8', $dbname='test', $acc='root', $pwd='123abc'){ 
        
        //初始化参数
        $this->type = $type;
        $this->host = $host;
        $this->port = $port;
        $this->charset = $charset;
        $this->dbname = $dbname;
        $this->acc = $acc;
        $this->pwd = $pwd;

        //连库基本操作
        $this->connect();

        //设置错误处理模式属性
        $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }

    #连库基本操作
    private function connect(){ 
        
        $dsn = "{$this->type}:host={$this->host};port={$this->port};charset={$this->charset};dbname={$this->dbname}";
        $this->pdo = new PDO($dsn, $this->acc, $this->pwd);
    }

    #设置操作
    public function setData($sql){ 
        
        try{
            $this->pdo->exec($sql);//监听执行增删改的操作
        }catch(PDOException $err){
            //输出错误信息
            echo '错误的代号：' . $err->getCode() . '<br/>'; 
            echo '错误的信息：' . $err->getMessage() . '<br/>'; 
            echo '错误的行号：' . $err->getLine() . '<br/>'; 
            echo '错误的文件：' . $err->getFile(); 
            return false;
        }
        return true;
    }

    #查一条数据
    public function getRow($sql){ 
        
        try{
            $pdostatement = $this->pdo->query($sql);//监听执行增删改的操作
        }catch(PDOException $err){
            //输出错误信息
            echo '错误的代号：' . $err->getCode() . '<br/>'; 
            echo '错误的信息：' . $err->getMessage() . '<br/>'; 
            echo '错误的行号：' . $err->getLine() . '<br/>'; 
            echo '错误的文件：' . $err->getFile(); 
            return false;
        }
        return $pdostatement->fetch(PDO::FETCH_ASSOC);//返回解析得到的一条关联数组数据
    }

    #查询多条数据
    public function getRows($sql){ 
        
        try{
            $pdostatement = $this->pdo->query($sql);//监听执行增删改的操作
        }catch(PDOException $err){
            //输出错误信息
            echo '错误的代号：' . $err->getCode() . '<br/>'; 
            echo '错误的信息：' . $err->getMessage() . '<br/>'; 
            echo '错误的行号：' . $err->getLine() . '<br/>'; 
            echo '错误的文件：' . $err->getFile(); 
            return false;
        }
        return $pdostatement->fetchAll();//返回解析得到的一条关联数组数据
    }
}
```




