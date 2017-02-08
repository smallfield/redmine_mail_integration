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
end
