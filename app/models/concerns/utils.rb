module Utils
  extend ActiveSupport::Concern

  def generate_uniq_code
    if self.reference_code.present? && self.reference_code.length != 6
      errors.add(:uniq_code, "length should be of 6 character")
    else
      self.reference_code = generate_random_uniq_code
    end

    self.reference_code
  end

  def generate_vendor_code
    if self.code.present? && self.code.length != 6
      errors.add(:uniq_code, "length should be of 6 character")
    else
      self.code = generate_random_vendor_uniq_code
    end

    self.code
  end

  def generate_random_vendor_uniq_code
    prifix = self.name.downcase.gsub(/\s+/, "")[0..6]
    count = 0
    token = nil
    while prifix.present?
      if count > 0
        token = prifix + '_' + count.to_s
      else
        token = prifix 
      end
      if self.class.where(code: token).blank?
        prifix = nil
      else
        count = count + 1
      end
    end
    token
  end

  def generate_random_uniq_code
    loop do
      token = random_number 6
      break token unless self.class.where(reference_code: token).present?
    end
  end

  def random_number(number)
    charset = Array(0..9) + Array('a'..'z')
    Array.new(number) { charset.sample }.join
  end

end