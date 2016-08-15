class ProvBid < ActiveRecord::Base
  set_primary_key :prov_bid_id

  belongs_to :status

  EMAIL_REGEX = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  validates_presence_of :name,
                        :email,
                        :postal_address,
                        :postcode,
                        :bidder_name,
                        :bid,
                        :bid_amount,
    :message => "cannot be empty"

  validates_format_of(:email,
                      :with => EMAIL_REGEX,
                      :message=> "has an invalid format",
                      :if => ModelHelper.only_check_if_not_empty(:email))

  validates_numericality_of :bid_amount

  validate :invalid_bid_amount, :must_agree_to_terms, :invalid_pay_method

  def invalid_bid_amount
    amount_limit = 5000.00
    if bid_amount < amount_limit
      errors.add(:bid_amount, "cannot be less than $#{amount_limit}")
    end
  end

  def must_agree_to_terms
    errors.add_to_base("You must agree to Terms and Conditions of the Tender process") unless terms_agreed
  end

  def invalid_pay_method
    errors.add_to_base("You must specify the pay method") if pay_method.blank? && pay_method_other.blank?
  end

  def self.pay_methods
    {
      "cash"             => "Cash",
      "cheque"           => "Cheque",
      "online_transfer"  => "Online Transfer",
      "visa"             => "Credit Card/Visa",
      "mastercard"       => "Credit Card/Mastercard"
    }
  end

  def self.bids
    {
      "de_castro-robinson" => "Eve de Castro-Robinson",
      "gendall"            => "Chris Gendall",
      "harris"             => "Ross Harris",
      "psathas"            => "John Psathas",
      "whitehead"          => "Gillian Whitehead"
    }
  end

end
