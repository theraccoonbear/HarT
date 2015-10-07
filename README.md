# HarT
Harvest Time

HarT is a Perl 5 command line tool and related modules used for interfacing with the Harvest time-keeping API.

HarT uses a variety of Perl modules.  You will need ensure that all of the module dependencies are installed.  cpanminus (cpanm) is the tool I recommend for this.  If you do not have cpanm, you can run the following:

```
$ curl -L https://cpanmin.us | perl - --sudo App::cpanminus
```

Once cpanm is installed, make sure you've got all of the modules you'll need:

```
$ sudo cpanm JSON::XS File::Slurp Moose Time::DayOfWeek DateTime::Format::Strptime FindBin File::Basename
```

When you first run HarT the script will create a config.json file for you based on config.sample.json.  You'll need to edit this file to include your specific settings.

If you're logged into your Harvest account, you can paste the following JavaScript snippet into your console to output the appropriate JSON (you'll still need to manually enter your password):

```
(function(){var J=JSON,d=document,u=J.parse(d.getElementById('error_tracking-data-island').innerHTML).user,o={hostname:d.location.hostname,email:u.email,user_id:u.id,password:'CHANGE-ME'};d.getElementsByTagName('body')[0].innerHTML='<pre>'+J.stringify(o,null,2)+'</pre>' }())
```