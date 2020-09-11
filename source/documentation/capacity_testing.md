# Capacity Testing

To simulate radius connections you can use the eapol_test tool with GNU parallel.  There are other radius performance testing tools available, however they do not support TLS and EAP which is why we need to use eapol_test.

As eapol_test only support a singular test, we must utilise GNU parallel to coordinate and record the running of many tests.  Parallel can run tasks in parallel and sequentially.

GNU parallel will run tasks in parallel up to the number of cores or CPUs available.  As the radius servers only have two cores it will only run 2 tests simeultaneously.

## Connection and Setup
```
ssh radius6.staging.govwifi
docker ps -a
docker exec -it 1c543f0449df /bin/sh
apk add parallel bash
```

## Configure Capacity Test Script
```
cat << EOF > test.sh
#!/usr/bin/env bash
number="${1:-10}"
export START=$(date)
seq $number | parallel --no-notice --env HEALTH_CHECK_RADIUS_KEY --joblog log.txt eapol_test -r0 -t3 -c peap-mschapv2.conf -a 127.0.0.1 -s $HEALTH_CHECK_RADIUS_KEY
sed -i  "s/$HEALTH_CHECK_RADIUS_KEY/<secret>/g" log.txt
export END=$(date)
echo "Start Time: $START"
echo "  End Time: $END"
EOF
chmod +x test.sh
```

## Running Capacity Tests

### To run 55 test logins:
`./test.sh 55`

### To run a single test login:
`eapol_test -r0 -t3 -c peap-mschapv2.conf -a 127.0.0.1 -s $HEALTH_CHECK_RADIUS_KEY`

or

`./test.sh 1`


## Results
```
/usr/src/healthcheck # ./test.sh 6
/usr/src/healthcheck # cat log.txt
Seq	Host	Starttime	JobRuntime	Send	Receive	Exitval	Signal	Command
1	:	1599839779.690	     0.023	0	59014	0	0	eapol_test -r0 -t3 -c peap-mschapv2.conf -a 127.0.0.1 -s <secret> 1
2	:	1599839779.692	     0.029	0	59014	0	0	eapol_test -r0 -t3 -c peap-mschapv2.conf -a 127.0.0.1 -s <secret> 2
3	:	1599839779.719	     0.033	0	59014	0	0	eapol_test -r0 -t3 -c peap-mschapv2.conf -a 127.0.0.1 -s <secret> 3
4	:	1599839779.728	     0.029	0	59014	0	0	eapol_test -r0 -t3 -c peap-mschapv2.conf -a 127.0.0.1 -s <secret> 4
6	:	1599839779.763	     0.029	0	59014	0	0	eapol_test -r0 -t3 -c peap-mschapv2.conf -a 127.0.0.1 -s <secret> 6
5	:	1599839779.757	     0.039	0	59014	0	0	eapol_test -r0 -t3 -c peap-mschapv2.conf -a 127.0.0.1 -s <secret> 5
```

Exitval shows whether eapol_test returned 0 for success and !0 for a failures
