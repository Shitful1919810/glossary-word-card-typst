# 日语生词学习模板 (Typst Word Card Template)

一个基于 **Typst** 的模板项目，用于记录日语学习中的生词笔记

项目中使用了 [`rubby`](https://typst.app/universe/package/rubby) 包来支持日语 **振假名（ルビ）** 的展示

## 项目简介

在日语学习过程中，我们常常需要：
- 为词语添加ruby
- 显示词义、例句
- 自动排列和排版词卡
- 控制不同单词块的布局和对齐

本项目通过 **Typst 宏** 实现了一个可复用的生词模板
提供了自动宽度计算、内容自适应、智能换行与视觉样式统一的 Typst 工具集

## 构建

### 安装 Typst 与 Python

先安装 [Typst](https://github.com/typst/typst) (>=0.14)

```bash
# macOS / Linux
brew install typst

# Windows
winget install --id Typst.Typst
```
并安装[Python](https://www.python.org/) (>=3.8)以及所有依赖包
```
pip install -r requirements.txt 
```

### 构建项目
使用下面的构建项目，构建得到的PDF文件将存放于`./build`目录下
```bash
# macOS / Linux
## 构建A4版文档
make build_a4

## 构建A5版文档
make build_a5

## 构建A4拼版A5版文档（短边装订）
make build_a4_short_side_a5

## 构建A4拼版A5版文档（长边装订）
make build_a4_long_side_a5

## 构建上述所有版本
make

## 清除所有已构建内容
make clean


# Windows (Powershell)
## 构建A4版文档
./build.bat a4

## 构建A5版文档
./build.bat a5

## 构建A4拼版A5版文档（短边装订）
./build.bat a4_short_side_a5

## 构建A4拼版A5版文档（长边装订）
./build.bat a4_long_side_a5

## 构建上述所有版本
./build.bat

## 清除所有已构建内容
./build.bat clean
```

