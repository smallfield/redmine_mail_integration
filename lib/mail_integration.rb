#coding:utf-8

require_dependency "mail_handler"

class MailHandler
  def dispatch_to_default_with_integration
    # 過去のメッセージIDの検索
    old_msg = MailMessage.find_by_message_id(email.message_id)
    old_msg = MailMessage.find_by_message_id(email.references) unless old_msg
    if old_msg
      #過去のIssueを更新する
      journal = receive_issue_reply(old_msg.issue_id)
      issue = journal.issue
    else
      #新しいIssueを作成する
      issue = receive_issue
    end
    issue
  end
  alias_method_chain :dispatch_to_default, :integration

  def dispatch_with_integration
    issue = dispatch_without_integration
    if(issue.is_a?(Issue))
      # MessageIDの履歴を登録
      msg = MailMessage.new
      msg.message_id = email.message_id
      msg.issue_id = issue.id
      msg.save!
      logger.info "MailHandler: Message-Id <#{email.message_id}> is correlated to issue ##{issue.id}"
    end
  end
  alias_method_chain :dispatch, :integration

  def cleanup_body_with_integration(body)
    "<pre>From: #{email.from.join(",")}\nTo: #{email.to.join(",")}\nCc: #{email.cc.join(",")}\nSubject: #{email.subject.to_s}\n\n#{cleanup_body_without_integration(body)}</pre>"
  end
  alias_method_chain :cleanup_body, :integration
end

# Issueモデルへのパッチ当て
module IssuePatch
  def self.included(base)
    base.class_eval do
      has_many :mail_message, dependent: :destroy
    end
  end
end
Issue.send(:include, IssuePatch)
