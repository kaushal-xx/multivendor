class Order < ApplicationRecord
  belongs_to :sme_user

  def generate_invoice
    pdf_string = Grover.new('http://localhost:3000/invoice', format: 'A4').to_pdf
    uniq_str = rand(36**8).to_s(36)
    save_path = Rails.root.join("tmp/invoice_#{ 12 }_inst_#{ uniq_str }.pdf")
    File.open(save_path, 'wb') do |file|
      file << pdf_string
    end
    save_path
  end
end