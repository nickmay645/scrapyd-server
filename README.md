# scrapyd-server

This is an attempt at using scrapy, scrapyd, and scrapyd-client to run spiders in Google Cloud.

#### Installation/Deploying
###### Create a VM Instance
Running Ubuntu 20.04.
Enable HTTP and HTTPS traffic.
Create a custom firewall rule enable TCP 6800 inbound for the VM.
###### SSH into the Google Compute Engine VM Instance.
Run the following commands:
```sh
sudo apt update
sudo apt install python3-pip
sudo apt install python3-venv

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate
pip install scrapyd

# Create a scrapyd.conf configuration file
touch scrapyd.conf

# Open the scrapy.conf with vim
vim scrapyd.conf
```
Paste the following into vim and the press `ESC` to get out of writing mode followed by `:wq` to save and exit vim.

```
[scrapyd]
eggs_dir            = eggs
logs_dir            = logs
items_dir           =
jobs_to_keep        = 5
dbs_dir             = dbs
max_proc            = 0
max_proc_per_cpu    = 4
finished_to_keep    = 100
poll_interval       = 5.0
bind_address        = 0.0.0.0
http_port           = 6800
debug               = off
runner              = scrapyd.runner
application         = scrapyd.app.application
launcher            = scrapyd.launcher.Launcher
webroot             = scrapyd.website.Root

[services]
schedule.json     = scrapyd.webservice.Schedule
cancel.json       = scrapyd.webservice.Cancel
addversion.json   = scrapyd.webservice.AddVersion
listprojects.json = scrapyd.webservice.ListProjects
listversions.json = scrapyd.webservice.ListVersions
listspiders.json  = scrapyd.webservice.ListSpiders
delproject.json   = scrapyd.webservice.DeleteProject
delversion.json   = scrapyd.webservice.DeleteVersion
listjobs.json     = scrapyd.webservice.ListJobs
```

Run the scrapyd server and check if you are able to connect via browser to the IP:6800
```sh
scrapyd
```

The output should be similar to:
```
[-] Loading ..\venv\Lib\site-packages\scrapyd\txapp.py...
[-] Basic authentication disabled as either `username` or `password` is unset
[-] Scrapyd web console available at http://127.0.0.1:6800/
[-] Loaded.
[twisted.application.app.AppLogger#info] twistd 22.10.0 (..\venv\Scripts\python.exe 3.12.0) starting up.
[twisted.application.app.AppLogger#info] reactor class: twisted.internet.selectreactor.SelectReactor.
[-] Site starting on 6800
[twisted.web.server.Site#info] Starting factory <twisted.web.server.Site object at 0x00000276CACB2F90>
[Launcher] Scrapyd 1.4.3 started: max_proc=96, runner='scrapyd.runner'
```

Check the scrapyd server by running http://external-ip-address:6800/
You should get a simple UI page.

TODO: Notes on nohup
TODO: images?

## References
[scrapyd](https://scrapyd.readthedocs.io/en/latest/)
[scrapyd-client](https://github.com/scrapy/scrapyd-client)
[How to run Scrapy Spiders on AWS EC2 instance using Scrapyd](https://mtuseeq.medium.com/how-to-run-scrapy-spiders-on-aws-ec2-instance-using-scrapyd-a6422961c017)

### Future Exploration
[Scrapy Clusters](https://freedium.cfd/https://python.plainenglish.io/harnessing-distributed-crawling-for-large-scale-web-scraping-tasks-00814ed37770)

