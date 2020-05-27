# request-smuggle-poc

Configure your /etc/hosts
```
127.0.0.1 app.test.in api.test.in
```
Launch Burp Suite and make sure you have `HTTP Request Smuggler` extension. Launch request smuggler and copy/paste the attack file. Run it.

Result:

![Result](https://github.com/psergus/request-smuggle-poc/blob/master/request-smuggle-poc.png)

Independent finding: https://www.cybersecurity-help.cz/vdb/SB2020011323
