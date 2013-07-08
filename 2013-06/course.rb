class Course

  attr_reader :token, :amount
  def initialize(token, amount)
    @token = token
    @amount = amount
  end

  def buy!(gateway)
    gateway.charge!(token, amount)
  end

  def legacy_buy!
    Stripe.charge!(token, amount)
  end
end

describe "real-world" do

  it "should be enterprise ready" do
    pending "am not ready"
    Stripe.stub(:charge!).and_raise(ETOOMANYAWESOMES)
    course = Course.new("ABSDF", 99)
    course.buy!(gateway)


  end

end

describe "buy!" do

  it "should be told to charge $99" do
    gateway = mock(:gateway)
    gateway.should_receive(:charge!).with("ABSDF", 99)
    course = Course.new("ABSDF", 99)
    course.buy!(gateway)
  end
end
