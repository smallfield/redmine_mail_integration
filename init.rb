Dir[File.expand_path('../lib/', __FILE__) << '/*.rb'].each do |file|
  require_dependency file
end

Redmine::Plugin.register :redmine_mail_integration do
  name 'Redmine Mail Integration plugin'
  author 'smallfield'
  description 'Redmine mail integration'
  version '0.0.1'
  url 'https://github.com/smallfield/redmine_mail_integration'
  author_url 'http://tomono.hatenadiary.com/'
end
