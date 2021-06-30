Djob 是一个基于[互联网计算机](https://dfinity.org/)的工作信息分享平台。你可以在上面免费发布工作信息，或者付费将工作信息置顶。

本项目有两个目的：
- 连接区块链从业者与产业最前线。
- 探索互联网计算机上的应用模式，以及登录与支付等功能。

互联网计算机（[Internet Computer](https://dfinity.org/)）是 Dfinity 基金会推出的自适应区块链，其智能合约（canister）可以承载传统 web 应用，因此也可以理解为一种去中心化的云服务平台（类比AWS、阿里云）。

### 运行

项目后端使用 Motoko 语言开发，前端使用 React 框架开发。

1. 安装 Internet Computer 本地环境

```
sh -ci "$(curl -fsSL https://sdk.dfinity.org/install.sh)"
```

2. clone 并进入项目

```
git clone https://github.com/futingfei/djob.git && cd djob
```

3. 运行本地环境并安装依赖

```
dfx start --background

npm install
```

4. 部署应用

```
dfx deploy
```

如果没有报错的话，找到输出结果中如下的字段：

... Installing code for canister djob_assets, with canister_id ryjl3-tyaaa-aaaaa-aaaba-cai ...

然后访问 http://127.0.0.1:8000/?canisterId=ryjl3-tyaaa-aaaaa-aaaba-cai （将 ryjl3-tyaaa-aaaaa-aaaba-cai 替换你对应字符串）。



### 相关资料

- [开发者文档](https://sdk.dfinity.org/docs/quickstart/quickstart-intro.html)
- [Motoko 语言教程](https://sdk.dfinity.org/docs/language-guide/motoko.html)
- 前端相关
  - [定制前端](https://sdk.dfinity.org/docs/developers-guide/tutorials/custom-frontend.html)
  - [添加 css](https://sdk.dfinity.org/docs/developers-guide/tutorials/my-contacts.html)
- 身份相关
  - [什么是互联网身份（Internet Identity）](https://sdk.dfinity.org/docs/ic-identity-guide/what-is-ic-identity.html)
  - [Internet Identity](https://identity.ic0.app/)
  - js 库：[agent](https://www.npmjs.com/package/@dfinity/agent)、 [authentication](https://www.npmjs.com/package/@dfinity/authentication)、[identity](https://www.npmjs.com/package/@dfinity/identity)
  - 教程：[如何与 Internet Identity 交互](https://kyle-peacock.com/blog/dfinity/integrating-internet-identity/)


