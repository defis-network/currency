## DAO
cleos system newaccount eosio jindaojindao EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  --stake-net "10.01 EOS" --stake-cpu "10.1 EOS" --buy-ram-kbytes 10000
cleos set contract jindaojindao /Users/joe/Workspace/newdex-workspace/jin-network/dao/build/dao -p jindaojindao
cleos push action jindaojindao setproxy '["jekyllisland"]' -p jindaojindao
cleos push action jindaojindao setperiod '[10]' -p jindaojindao
cleos push action jindaojindao setoracle '["jinoracle111"]' -p jindaojindao
cleos push action jindaojindao setmid '[0]' -p jindaojindao
cleos push action jindaojindao setlower '[1]' -p jindaojindao

cleos get table jindaojindao jindaojindao configs

## Bank
cleos system newaccount eosio jinbankoneos EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  --stake-net "10.01 EOS" --stake-cpu "10.1 EOS" --buy-ram-kbytes 10000 --transfer
cleos set contract jinbankoneos /Users/joe/Workspace/newdex-workspace/jin-network/currency/build/currency -p jinbankoneos@owner
cleos set account permission jinbankoneos active '{"threshold": 1,"keys": [],"accounts":[{"permission":{"actor":"jinbankoneos","permission":"eosio.code"},"weight":1}]}' owner -p jinbankoneos@owner

cleos push action jinbankoneos init '["jindaojindao", "100000000000.0000 JIN"]' -p jinbankoneos@owner
cleos push action jinbankoneos vote '[]' -p jinbankoneos@owner
cleos  get table jinbankoneos jinbankoneos globals 

## Swap
cleos system newaccount eosio jinswap11111 EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  --stake-net "10.01 EOS" --stake-cpu "10.1 EOS" --buy-ram-kbytes 10000

cleos set contract jinswap11111 /Users/joe/Workspace/newdex-workspace/jin-network/swap/build/swap -p jinswap11111@owner

cleos set account permission jinswap11111 active '{"threshold": 1,"keys": [],"accounts":[{"permission":{"actor":"jinswap11111","permission":"eosio.code"},"weight":1}]}' owner -p jinswap11111@owner

cleos transfer joetothemoon jinbankoneos "1000.0000 EOS" "mint" -p joetothemoon@owner

cleos push action jinswap11111 newmarket '["joetothemoon", "eosio.token", "jinbankoneos", "4,EOS", "4,JIN"]' -p joetothemoon@owner
cleos push action jinswap11111 newmarket '["joetothemoon", "eosio.token", "tethertether", "4,EOS", "4,USDT"]' -p joetothemoon@owner
cleos push action jinswap11111 newmarket '["joetothemoon", "eosio.token", "tethertether", "4,TNT", "4,USDT"]' -p joetothemoon@owner
cleos push action jinswap11111 newmarket '["joetothemoon", "tethertether", "eosio.token", "4,USDT", "4,EOS"]' -p joetothemoon@owner

cleos push action jinswap11111 deposit '["joetothemoon",1]' -p joetothemoon@owner
cleos transfer -c jinbankoneos joetothemoon jinswap11111  "300.0000 JIN" "deposit"   -p joetothemoon@owner
cleos transfer joetothemoon jinswap11111  "100.0000 EOS" "deposit"   -p joetothemoon@owner

cleos get table jinswap11111 jinswap11111 markets 
cleos get table jinswap11111 1 liquidity 

cleos transfer -c jinbankoneos joetothemoon jinswap11111  "300.0000 JIN" "swap:1"  
cleos transfer joetothemoon jinswap11111  "100.0000 EOS" "swap:1"  

cleos transfer -c jinbankoneos joetothemoon jinswap11111  "3.0000 JIN" "swap:1"   -p joetothemoon@owner
cleos transfer joetothemoon jinswap11111  "1.0000 EOS" "swap:1"   -p joetothemoon@owner

cleos push action jinswap11111 withdraw '["joetothemoon",1, 1722050]' -p joetothemoon 

## Price
cleos system newaccount eosio jinprice1112 EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  --stake-net "10.01 EOS" --stake-cpu "10.1 EOS" --buy-ram-kbytes 10000 --transfer
cleos set contract jinprice1112 /Users/joe/Workspace/newdex-workspace/jin-network/feed/build/source -p jinprice1112
cleos push action jinprice1112 create '["eosio.token", "jinbankoneos", "4,EOS", "4,JIN"]' -p jinprice1112

cleos get table jinprice1112 jinprice1112 markets 

## Oracle
cleos system newaccount eosio jinoracle111 EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  --stake-net "10.01 EOS" --stake-cpu "10.1 EOS" --buy-ram-kbytes 10000 --transfer
cleos set contract jinoracle111 /Users/joe/Workspace/newdex-workspace/jin-network/oracle/build/oracle -p jinoracle111@owner
cleos set account permission jinoracle111 active '{"threshold": 1,"keys": [],"accounts":[{"permission":{"actor":"jinoracle111","permission":"eosio.code"},"weight":1}]}' owner -p jinoracle111@owner

cleos  push action jinoracle111 init '["jinprice1112"]' -p jinoracle111@owner

cleos get table jinoracle111 0 avgprices -l 2
cleos get table jinoracle111 jinoracle111 globals

## Oracle V2
cleos system newaccount eosio jinoracle112 EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  --stake-net "10.01 EOS" --stake-cpu "10.1 EOS" --buy-ram-kbytes 10000 --transfer
cleos set contract jinoracle112 /Users/joe/Workspace/newdex-workspace/jin-network/oracle/build/oracle -p jinoracle112@owner
cleos set account permission jinoracle112 active '{"threshold": 1,"keys": [],"accounts":[{"permission":{"actor":"jinoracle112","permission":"eosio.code"},"weight":1}]}' owner -p jinoracle112@owner

cleos  push action jinoracle112 init '["jinswap11111"]' -p jinoracle112@owner

cleos get table jinoracle112 1 avgprices -l 2
cleos get table jinoracle112 jinoracle112 globals


## trigger
cd /Users/joe/Workspace/newdex-workspace/jin-network/trigger
./release_test.sh

## HYK Token 
cleos system newaccount eosio jindaotokens EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  --stake-net "10.01 EOS" --stake-cpu "10.1 EOS" --buy-ram-kbytes 10000 --transfer
cleos system newaccount eosio jinteamfunds EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  --stake-net "10.01 EOS" --stake-cpu "10.1 EOS" --buy-ram-kbytes 10000 --transfer

cleos set contract jindaotokens /Users/joe/Workspace/newdex-workspace/jin-network/token/build/token -p jindaotokens

cleos push action jindaotokens create '["jinteamfunds", "10000000.0000 HYK"]'  -p jindaotokens@owner

cleos set account permission jindaotokens active '{"threshold": 1,"keys": [{"key": "EOS1111111111111111111111111111111114T1Anm","weight": 1}],"accounts":[]}' owner -p jindaotokens@owner
cleos set account permission jindaotokens owner '{"threshold": 1,"keys": [{"key": "EOS1111111111111111111111111111111114T1Anm","weight": 1}],"accounts":[]}' -p jindaotokens@owner

cleos get account jindaotokens
cleos get currency stats jindaotokens HYK
cleos get table jindaotokens jindaotokens limit

cleos push action jindaotokens issue '["jinteamfunds", "1000000.0000 HYK", "init"]' -p jinteamfunds

cleos transfer -c jindaotokens jinteamfunds joetothemoon  "300000.0000 HYK" "swap:1" 

## Token sell
cleos system newaccount eosio jintokensell EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  --stake-net "10.01 EOS" --stake-cpu "10.1 EOS" --buy-ram-kbytes 10000 --transfer
cleos set contract jintokensell /Users/joe/Workspace/newdex-workspace/jin-network/crowdfunding/build/crowdfunding -p jintokensell@owner
cleos set account permission jintokensell active '{"threshold": 1,"keys": [],"accounts":[{"permission":{"actor":"jintokensell","permission":"eosio.code"},"weight":1}]}' owner -p jintokensell@owner
cleos get account  jintokensell

cleos transfer -c jindaotokens jinteamfunds jintokensell  "200000.00 HYK" "swap:1" 
cleos transfer -c jindaotokens joetothemoon jintokensell "1.0000 HYK" "HYK swap" 
cleos transfer joetothemoon jintokensell "11.0000 EOS" "HYK swap" 

## Token sell in swap

cleos push action jinswap11111 newmarket '["joetothemoon", "eosio.token", "jindaotokens", "4,EOS", "4,HYK"]' -p joetothemoon



cleos push action jinswap11111 deposit '["joetothemoon",2]' -p joetothemoon
cleos transfer -c jindaotokens joetothemoon jinswap11111  "300.0000 HYK" "deposit"  
cleos transfer joetothemoon jinswap11111  "100.0000 EOS" "deposit"  


cleos transfer joetothemoon jinswap11111 "1.0000 EOS" "swap:2"  
cleos transfer joetothemoon jinswap11111 "10.0000 EOS" "swap:1"  -p joetothemoon@owner


cleos get table jinswap11111 jinswap11111 markets 
cleos get table jinswap11111 2 liquidity 


