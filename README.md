redmine_mail_integration
===

## Description
Plugin that correlate emails to the existing Redmine issues when recieved.

### Behavior
When Redmine recieved email.....

1. If subject includes ticket ID (ex. #123) or the mail is reply to the Redmine notification email then update the ticket. (This is Redmine default.)
1. This plugin checks `Message-Id` and `References` headers.
  1. If `Message-Id` or `References` incluedes known `Message-Id`, update the ticket related to the known `Message-Id`.
  1. If it seems new message, create a new ticket.
1. Save `Message-Id` and related ticket(updated or created) ID to the Redmine database. 

### Original Idea
http://d.hatena.ne.jp/coolstyle/20110708/1310100053

## Requirement
Tested on Redmine v3.3.1

## Install / Usage
```
$ cd /your/redmine/plugins
$ git clone https://github.com/smallfield/redmine_mail_integration.git
$ bundle exec rake redmine:plugins:migrate NAME=redmine_mail_integration
```

## Author

[smallfield](http://tomono.hatenadiary.com/)
