class Users::ContactMailer < ApplicationMailer
  
  def contact_mail(contact)
    @contact = contact
    mail to: ENV['SMTP_USERNAME'], subject: 'お問い合わせ'
  end

end
