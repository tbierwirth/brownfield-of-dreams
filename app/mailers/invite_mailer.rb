class InviteMailer < ApplicationMailer
  def invite(sender, recipient, email)
    @sender = sender
    @recipient = recipient
    mail(to: email, subject: "Brownfield of Dreams Invite")
  end
end
