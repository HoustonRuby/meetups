require 'rspec'

class Person 

  attr_accessor :age, :friends, :dont_date_list

  def initialize(age)
    @age = age
    @friends = []
    @dont_date_list = []
  end

  def drive?
    age >= 16
  end

  def drives_well?
    age >= 25
  end

  def nice?
    true
  end

  def really_expensive_twitter_search
    sleep 2
    return "yuck"
  end

  def dont_date(other_person)
    @dont_date_list << other_person
  end
end


describe Person do

  let(:age) { 15 }
  subject do
    Person.new(age)
  end

  it "should be nice" do
    subject.should be_nice
  end

  context "15 year old" do
    it "should not be able to drive at 15" do
      subject.drive?.should be_false
    end
  end

  context "16 year old" do
    let(:age) { 16 }

    it "should be able to drive at 16" do
      expect(subject.drive?).to_not be
    end

    it "does not drive well at 16" do
      subject.drives_well?.should be_false
    end

  end

  context "25 year old" do
    let(:age) { 25 }

    it "drives well at 25" do
      subject.drives_well?.should be_true
    end

    it "should tell a friend not to date other friend" do
      that_friend = double
      friend = double
      friend.should_receive(:dont_date).with(that_friend)
      friend.dont_date(that_friend)

    end

    it "should not ignore when friends tell not to date" do
      that_friend = double
      subject.dont_date(that_friend)
      subject.dont_date_list.should include(that_friend)
    end
  end


  context "ollld" do

    it "should be 99" do
      subject.stub(:really_expensive_twitter_search) { 42 }
      puts "about to search"
      puts subject.really_expensive_twitter_search
      puts "dunzo"
    end

    it "has friends" do
      fred = Person.new(30)
      sam = double(:person)
      sam.stub(:drive?) { true }
      fred.friends << sam
      fred.friends.should == [sam]
      fred.friends.first.drive?.should be_true
    end

    
  end
end
