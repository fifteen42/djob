#!/bin/bash

dfx stop
rm -rf .dfx

ALICE_HOME=$(mktemp -d -t alice-temp)
BOB_HOME=$(mktemp -d -t bob-temp)
DAN_HOME=$(mktemp -d -t dan-temp)
HOME=$ALICE_HOME

ALICE_PUBLIC_KEY="principal \"$(HOME=$ALICE_HOME dfx identity get-principal)\""
BOB_PUBLIC_KEY="principal \"$(HOME=$BOB_HOME dfx identity get-principal)\""
DAN_PUBLIC_KEY="principal \"$(HOME=$DAN_HOME dfx identity get-principal)\""

echo Alice id = $ALICE_PUBLIC_KEY
echo Bob id = $BOB_PUBLIC_KEY
echo Dan id = $DAN_PUBLIC_KEY

dfx start --background
dfx canister --no-wallet create djob
dfx build djob

echo
echo == install djob backend
eval dfx canister --no-wallet install djob
echo

echo == get own id
eval HOME=$ALICE_HOME dfx canister --no-wallet call djob getOwnId
eval HOME=$BOB_HOME dfx canister --no-wallet call djob getOwnId
eval HOME=$DAN_HOME dfx canister --no-wallet call djob getOwnId
echo

echo == alice create 2 jobs
eval HOME=$ALICE_HOME dfx canister call djob create "'(record { title = \"rust 工程师\"; company = \"太太科技\";  location = \"上海\"; tag = vec {\"rust\"; \"icp\"}; description = \"牛逼的工作\"; salaryFloor = 10000; salaryCeiling = 20000; email = \"alice@gmail.com\";})'"
eval HOME=$ALICE_HOME dfx canister call djob create "'(record { title = \"java 工程师\"; company = \"太太科技\";  location = \"上海\"; tag = vec {\"java\"; \"dfinity\"}; description = \"牛逼的工作\"; salaryFloor = 9000; salaryCeiling = 15000; email = \"alice@gmail.com\";})'"
echo
echo == bob create 2 jobs
eval HOME=$BOB_HOME dfx canister call djob create "'(record { title = \"python 工程师\"; company = \"哥哥科技\";  location = \"北京\"; tag = vec {\"python\"; \"love\"}; description = \"牛逼的工作\"; salaryFloor = 10000; salaryCeiling = 20000; email = \"bob@gmail.com\";})'"
eval HOME=$BOB_HOME dfx canister call djob create "'(record { title = \"nodejs 工程师\"; company = \"哥哥科技\";  location = \"北京\"; tag = vec {\"nodejs\"; \"hehe\"}; description = \"牛逼的工作\"; salaryFloor = 30000; salaryCeiling = 70000; email = \"bob@gmail.com\";})'"
echo
echo == dan create 2 jobs
eval HOME=$DAN_HOME dfx canister call djob create "'(record { title = \"ruby 工程师\"; company = \"妈妈科技\";  location = \"新加坡\"; tag = vec {\"good\"; \"apple\"}; description = \"牛逼的工作\"; salaryFloor = 30000; salaryCeiling = 70000; email = \"dan@gmail.com\";})'"
eval HOME=$DAN_HOME dfx canister call djob create "'(record { title = \"cpp 工程师\"; company = \"妈妈科技\";  location = \"新加坡\"; tag = vec {\"bad\"; \"huawei\"}; description = \"牛逼的工作\"; salaryFloor = 30000; salaryCeiling = 70000; email = \"dan@gmail.com\";})'"
echo

echo == get job: 1, 3, 5
dfx canister call djob get 1
dfx canister call djob get 3
dfx canister call djob get 5
echo

echo == alice update job 1: success
eval HOME=$ALICE_HOME dfx canister call djob update "'(record {id = 1; ownerId = $ALICE_PUBLIC_KEY;  title = \"超级 rust 工程师\"; company = \"太太科技\";  location = \"上海\"; tag = vec {\"rust\"; \"icp\"}; description = \"牛逼的工作\"; salaryFloor = 10000; salaryCeiling = 20000; email = \"alice@gmail.com\"; isDeleted = false;})'"
eval dfx canister call djob get 1
echo

echo == bob update job 2: error
eval HOME=$BOB_HOME dfx canister call djob update "'(record {id = 2; ownerId = $ALICE_PUBLIC_KEY;  title = \"超级 rust 工程师\"; company = \"太太科技\";  location = \"上海\"; tag = vec {\"rust\"; \"icp\"}; description = \"牛逼的工作\"; salaryFloor = 10000; salaryCeiling = 20000; email = \"alice@gmail.com\"; isDeleted = false;})'"
eval dfx canister call djob get 2
echo

echo == alice delete job 1: success
eval HOME=$ALICE_HOME dfx canister call djob delete 1
eval dfx canister call djob get 1
echo

echo == alice delete job 3 which owned by bob: false
eval HOME=$ALICE_HOME dfx canister call djob delete 3
eval dfx canister call djob get 3
echo

echo == search job contains 太太科技
eval dfx canister call djob search \"太太科技\"
echo

echo == search job contains love
eval dfx canister call djob search \"love\"
echo

echo == get all jobs without the delelted
eval dfx canister call djob getAll
echo

echo == get all delelted jobs 
eval dfx canister call djob getDeleted
echo

dfx stop