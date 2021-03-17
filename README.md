## djob

A decentralized job infomation sharing platform based on ICP (Dfinity) with motoko as backend and react as frontend.

Learn from [Linkedup](https://github.com/dfinity/linkedup).
### install

Assume the ICP enviroment is ready.

1. download djob

`git clone git@github.com:FUTingFei/djob.git && cd djob`

2. deploy djob to local replica

`dfx start --background`

`dfx deploy`

### backend usage

```

dfx canister call djob getOwnId
(principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe")

dfx canister call djob create '(record { title = "rust 工程师"; company = "泰砥科技";  location = "上海"; tag = vec{"rust"; "cita"}; description = "牛逼的工作"; salaryFloor = 10000; salaryCeiling = 20000; email = "tingfei.fu@taiditech.com";})'
(
  "The Owner { rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe } crate a job with id : 1",
)

dfx canister call djob create '(record { title = "java 工程师"; company = "SNZ";  location = "上海"; tag = vec{"java"; "spring"}; description = "牛逼的工作"; salaryFloor = 15000; salaryCeiling = 30000; email = "tingfei.fu@taiditech.com";})'
(
  "The Owner { rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe } crate a job with id : 2",
)

dfx canister call djob create '(record { title = "python 工程师"; company = "SNZ";  location = "上海"; tag = vec{"python"; "panda"}; description = "牛逼的工作"; salaryFloor = 15000; salaryCeiling = 30000; email = "tingfei.fu@taiditech.com";})'
(
  "The Owner { rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe } crate a job with id : 3",
)


dfx canister call djob getAll
(
  vec {
    record {
      id = 2;
      tag = vec { "java"; "spring" };
      title = "java 工程师";
      isDeleted = false;
      ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
      description = "牛逼的工作";
      email = "tingfei.fu@taiditech.com";
      salaryCeiling = 30_000;
      company = "SNZ";
      location = "上海";
      salaryFloor = 15_000;
    };
    record {
      id = 3;
      tag = vec { "python"; "panda" };
      title = "python 工程师";
      isDeleted = false;
      ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
      description = "牛逼的工作";
      email = "tingfei.fu@taiditech.com";
      salaryCeiling = 30_000;
      company = "SNZ";
      location = "上海";
      salaryFloor = 15_000;
    };
    record {
      id = 1;
      tag = vec { "rust"; "cita" };
      title = "rust 工程师";
      isDeleted = false;
      ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
      description = "牛逼的工作";
      email = "tingfei.fu@taiditech.com";
      salaryCeiling = 20_000;
      company = "泰砥科技";
      location = "上海";
      salaryFloor = 10_000;
    };
  },
)

dfx canister call djob delete 2
()

dfx canister call djob getAll
(
  vec {
    record {
      id = 3;
      tag = vec { "python"; "panda" };
      title = "python 工程师";
      isDeleted = false;
      ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
      description = "牛逼的工作";
      email = "tingfei.fu@taiditech.com";
      salaryCeiling = 30_000;
      company = "SNZ";
      location = "上海";
      salaryFloor = 15_000;
    };
    record {
      id = 1;
      tag = vec { "rust"; "cita" };
      title = "rust 工程师";
      isDeleted = false;
      ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
      description = "牛逼的工作";
      email = "tingfei.fu@taiditech.com";
      salaryCeiling = 20_000;
      company = "泰砥科技";
      location = "上海";
      salaryFloor = 10_000;
    };
  },
)

dfx canister call djob getAllD
(
  vec {
    record {
      id = 2;
      tag = vec { "java"; "spring" };
      title = "java 工程师";
      isDeleted = true;
      ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
      description = "牛逼的工作";
      email = "tingfei.fu@taiditech.com";
      salaryCeiling = 30_000;
      company = "SNZ";
      location = "上海";
      salaryFloor = 15_000;
    };
    record {
      id = 3;
      tag = vec { "python"; "panda" };
      title = "python 工程师";
      isDeleted = false;
      ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
      description = "牛逼的工作";
      email = "tingfei.fu@taiditech.com";
      salaryCeiling = 30_000;
      company = "SNZ";
      location = "上海";
      salaryFloor = 15_000;
    };
    record {
      id = 1;
      tag = vec { "rust"; "cita" };
      title = "rust 工程师";
      isDeleted = false;
      ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
      description = "牛逼的工作";
      email = "tingfei.fu@taiditech.com";
      salaryCeiling = 20_000;
      company = "泰砥科技";
      location = "上海";
      salaryFloor = 10_000;
    };
  },
)

dfx canister call djob update '(record {id = 1; ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe"; title = "rust 工程师"; company = "太太科技";  location = "上海"; tag = vec{"rust"; "cita"}; description = "牛逼的工作"; salaryFloor = 10000; salaryCeiling = 20000; email = "tingfei.fu@taiditech.com"; isDeleted = false;})'
()

dfx canister call djob get 1
(
  opt record {
    id = 1;
    tag = vec { "rust"; "cita" };
    title = "rust 工程师";
    isDeleted = false;
    ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
    description = "牛逼的工作";
    email = "tingfei.fu@taiditech.com";
    salaryCeiling = 20_000;
    company = "太太科技";
    location = "上海";
    salaryFloor = 10_000;
  },
)


dfx canister call djob search "rust"
(
  vec {
    record {
      id = 1;
      tag = vec { "rust"; "cita" };
      title = "rust 工程师";
      isDeleted = false;
      ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe";
      description = "牛逼的工作";
      email = "tingfei.fu@taiditech.com";
      salaryCeiling = 20_000;
      company = "太太科技";
      location = "上海";
      salaryFloor = 10_000;
    };
  },
)

```


### to-do

- [ ] backend
  - [x] CURD
  - [ ] payment related things with cycles
- [ ] frontend