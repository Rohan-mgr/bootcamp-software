class CustomerMailer < ApplicationMailer
  def order_deletion_email(customer, order, organization)
    @customer = customer
    @order = order
    @organization = organization
    mail(to: "pkonami696@gmail.com", from: "Bootcamp SAAS", subject: "Information about order deletion")
  end
end
