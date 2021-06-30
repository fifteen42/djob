dfx canister call djob getOwnId

dfx canister call djob create '(record { title = "rust 工程师"; company = "泰砥科技";  location = "上海"; tag = vec{"rust"; "cita"}; description = "牛逼的工作"; salaryFloor = 10000; salaryCeiling = 20000; email = "tingfei.fu@taiditech.com";})'

dfx canister call djob create '(record { title = "java 工程师"; company = "SNZ";  location = "上海"; tag = vec{"java"; "spring"}; description = "牛逼的工作"; salaryFloor = 15000; salaryCeiling = 30000; email = "tingfei.fu@taiditech.com";})'

dfx canister call djob create '(record { title = "python 工程师"; company = "SNZ";  location = "上海"; tag = vec{"python"; "panda"}; description = "牛逼的工作"; salaryFloor = 15000; salaryCeiling = 30000; email = "tingfei.fu@taiditech.com";})'

dfx canister call djob getAll

dfx canister call djob delete 2

dfx canister call djob getAll

dfx canister call djob getAllD

dfx canister call djob update '(record {id = 1; ownerId = principal "rbyiv-go2kc-uqegy-mron3-mca6w-u42ww-tz7v7-zz7om-hpbov-ozqax-yqe"; title = "rust 工程师"; company = "太太科技";  location = "上海"; tag = vec{"rust"; "cita"}; description = "牛逼的工作"; salaryFloor = 10000; salaryCeiling = 20000; email = "tingfei.fu@taiditech.com"; isDeleted = false;})'

dfx canister call djob get 1

dfx canister call djob search "rust"