#coding:utf-8

require_dependency "mail_handler"

class MailHandler
  def dispatch_to_default_with_integration
    # find from saved Message-Id
    old_msg = MailMessage.find_by_message_id(email.message_id)
    old_msg = MailMessage.find_by_message_id(email.references) unless old_msg
    if old_msg
      # Update existing issue
      journal = receive_issue_reply(old_msg.issue_id)
      issue = journal.issue
    else
      # create new issue
      issue = receive_issue
    end
    issue
  end
  alias_method_chain :dispatch_to_default, :integration

  def dispatch_with_integration
    issue = dispatch_without_integration
    if(issue.is_a?(Issue))
      # Save Message-Id
      msg = MailMessage.new
      msg.message_id = email.message_id
      msg.issue_id = issue.id
      msg.save!
      logger.info "MailHandler: Message-Id <#{email.message_id}> is correlated to issue ##{issue.id}"
    end
    issue
  end
  alias_method_chain :dispatch, :integration

  def cleanup_body_with_integration(body)
    from = email.from.to_a.join(", ")
    to = email.to.to_a.join(", ")
    cc = email.cc.to_a.join(", ")
    "~~~\n   From: #{from}\n     To: #{to}\n     Cc: #{cc}\nSubject: #{email.subject.to_s}\n\n#{cleanup_body_without_integration(body)}\n~~~"
  end
  alias_method_chain :cleanup_body, :integration
end

# Issue model patching
module IssuePatch
  def self.included(base)
    base.class_eval do
      has_many :mail_message, dependent: :destroy
    end
  end
end
Issue.send(:include, IssuePatch)
