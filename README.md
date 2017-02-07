redmine_mail_integration
===

## Description
Redmineでメール受信時に、既存メール取り込みチケットへの返信メールだったら、その既存のチケットに紐付けるようにするためのプラグイン。

もとは[こちら](http://d.hatena.ne.jp/coolstyle/20110708/1310100053)で id:coolstyle さんが作成、公開されていたものを、最近のRedmineで動作するように作り直したもの。

## Requirement
Redmine v3.3.1 で動作確認済み。

## Install / Usage
```
$ cd /your/redmine/plugins
$ git clone https://github.com/smallfield/redmine_mail_integration.git
$ bundle exec rake redmine:plugins:migrate NAME=redmine_mail_integration
```

## Author

[smallfield](http://tomono.hatenadiary.com/)
